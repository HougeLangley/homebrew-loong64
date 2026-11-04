class Ginac < Formula
  desc "Not a Computer algebra system"
  homepage "https://www.ginac.de/"
  url "https://www.ginac.de/ginac-1.8.10.tar.bz2"
  sha256 "6cac1973a5325de0b9bcb8e392988ae95fbc37aa66c0f1f1d3b8e64c08cec1b9"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://www.ginac.de/Download.html"
    regex(/href=.*?ginac[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c133b0a24131d187d5059c7e4d8617a5b274c9f0905830e4256acb1d6d2192af"
  end

  depends_on "pkgconf" => :build
  depends_on "cln"
  depends_on "readline"

  uses_from_macos "python" => :build

  deny_network_access!

  def install
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <iostream>
      #include <ginac/ginac.h>
      using namespace std;
      using namespace GiNaC;

      int main() {
        symbol x("x"), y("y");
        ex poly;

        for (int i=0; i<3; ++i) {
          poly += factorial(i+16)*pow(x,i)*pow(y,2-i);
        }

        cout << poly << endl;
        return 0;
      }
    CPP
    system ENV.cxx, "-std=c++11", "test.cpp", "-o", "test",
                    "-L#{lib}", "-L#{Formula["cln"].lib}", "-lcln", "-lginac"
    system "./test"
  end
end
