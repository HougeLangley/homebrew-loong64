class Systemc < Formula
  desc "Core SystemC language and examples"
  homepage "https://systemc.org/overview/systemc/"
  url "https://github.com/accellera-official/systemc/archive/refs/tags/3.0.2.tar.gz"
  sha256 "9b3693ed286aab958b9e5d79bb0ad3bc523bbc46931100553275352038f4a0c4"
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end




  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "2bdd10e9cdbfc7624171c0c1583387fe9e33335c72dfdca16fad55b5e8ce2e54"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    # systemc bakes the C++ standard into its ABI symbol name
    # (sc_api_version_..._cxx201703L vs _cxx202002L). GCC 16's default
    # builds the library as C++20 while the upstream test compiles with
    # -std=gnu++17, causing an undefined-reference at link. Pin the whole
    # build to C++17 so library and test ABIs match.
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args,
           "-DCMAKE_CXX_STANDARD=17",
           "-DCMAKE_CXX_EXTENSIONS=ON"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include "systemc.h"

      int sc_main(int argc, char *argv[]) {
        return 0;
      }
    CPP
    system ENV.cxx, "-std=gnu++17", "-L#{lib}", "-lsystemc", "test.cpp"
    system "./a.out"
  end
end
