class Scnlib < Formula
  desc "Scanf for modern C++"
  homepage "https://www.scnlib.dev/"
  url "https://github.com/eliaskosunen/scnlib/archive/refs/tags/v4.0.1.tar.gz"
  sha256 "ece17b26840894cc57a7127138fe4540929adcb297524dec02c490c233ff46a7"
  license "Apache-2.0"
  revision 2
  head "https://github.com/eliaskosunen/scnlib.git", branch: "master"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "8f83ce1a1bb50c64b4738c99008e1dc0ae1d4261d99fabf3dc5e6b1b69a4a3f9"
  end



  depends_on "cmake" => :build
  depends_on "simdutf"

  def install
    args = %w[
      -DBUILD_SHARED_LIBS=ON
      -DSCN_TESTS=OFF
      -DSCN_DOCS=OFF
      -DSCN_EXAMPLES=OFF
      -DSCN_BENCHMARKS=OFF
      -DSCN_BENCHMARKS_BUILDTIME=OFF
      -DSCN_BENCHMARKS_BINARYSIZE=OFF
      -DSCN_USE_EXTERNAL_SIMDUTF=ON
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <scn/scan.h>
      #include <cstdlib>
      #include <string>

      int main()
      {
        constexpr int expected = 123456;
        auto [result] = scn::scan<int>(std::to_string(expected), "{}")->values();
        return result == expected ? EXIT_SUCCESS : EXIT_FAILURE;
      }
    CPP

    system ENV.cxx, "-std=c++17", "test.cpp", "-o", "test", "-I#{include}", "-L#{lib}", "-lscn"
    system "./test"
  end
end
