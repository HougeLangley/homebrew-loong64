class Yazpp < Formula
  desc "C++ API for the Yaz toolkit"
  homepage "https://www.indexdata.com/resources/software/yazpp/"
  url "https://ftp.indexdata.com/pub/yazpp/yazpp-1.9.2.tar.gz"
  sha256 "92516d1d889dd6ff617d92b3af0ba28861dbd1fc436cfcadd0fde65ca9f34fe9"
  license "BSD-3-Clause"

  livecheck do
    url "https://ftp.indexdata.com/pub/yazpp/"
    regex(/href=.*?yazpp[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "effba5bae77c572cae88adacfd5b1ac649e31620a672de152c31bc3b63861fc8"
  end

  depends_on "pkgconf" => :build
  depends_on "yaz"

  deny_network_access!

  def install
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <iostream>
      #include <yazpp/zoom.h>

      using namespace ZOOM;

      int main(int argc, char **argv){
        try
        {
          connection conn("wrong-example.xyz", 210);
        }
        catch (exception &e)
        {
          std::cout << "Exception caught";
        }
        return 0;
      }
    CPP

    system ENV.cxx, "test.cpp", "-std=c++11", "-I#{include}/src",
                    "-L#{lib}", "-lzoompp", "-o", "test"
    output = shell_output("./test")
    assert_match "Exception caught", output
  end
end
