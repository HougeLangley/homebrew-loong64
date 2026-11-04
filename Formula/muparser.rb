class Muparser < Formula
  desc "C++ math expression parser library"
  homepage "https://github.com/beltoforion/muparser"
  url "https://github.com/beltoforion/muparser/archive/refs/tags/v2.3.5.tar.gz"
  sha256 "20b43cc68c655665db83711906f01b20c51909368973116dfc8d7b3c4ddb5dd4"
  license "BSD-2-Clause"
  revision 2
  head "https://github.com/beltoforion/muparser.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "4b82e28408bea5c6093d2c86ccb05dd9ea1cb3aa7e01a10b7282257e4ce8491e"
  end

  depends_on "cmake" => :build

  on_macos do
    depends_on "libomp"
  end

  link_overwrite "lib/libmuparser.dylib", "lib/libmuparser.2.dylib"

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", "-DENABLE_OPENMP=ON", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <iostream>
      #include <muParser.h>

      double MySqr(double a_fVal) {
        return a_fVal*a_fVal;
      }

      int main() {
        using namespace mu;

        try {
          double fVal = 1;
          Parser p;
          p.DefineVar("a", &fVal);
          p.DefineFun("MySqr", MySqr);
          p.SetExpr("MySqr(a)*_pi+min(10,a)");

          for (std::size_t a=0; a<100; ++a)
          {
            fVal = a;  // Change value of variable a
            std::cout << p.Eval() << std::endl;
          }
        } catch (Parser::exception_type &e) {
          std::cout << e.GetMsg() << std::endl;
        }

        return 0;
      }
    CPP

    system ENV.cxx, "-std=c++11", "test.cpp", "-o", "test", "-I#{include}", "-L#{lib}", "-lmuparser"
    system "./test"
  end
end
