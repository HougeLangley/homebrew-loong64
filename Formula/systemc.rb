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




  depends_on "cmake" => :build

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
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
