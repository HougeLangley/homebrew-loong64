class Healpix < Formula
  desc "Hierarchical Equal Area isoLatitude Pixelization of a sphere"
  homepage "https://healpix.sourceforge.io"
  url "https://downloads.sourceforge.net/project/healpix/Healpix_3.83/Healpix_3.83_2024Nov13.tar.gz"
  version "3.83"
  sha256 "8876c18efc596fd706b2a004ac15f2fb60b795f2db6fbabea9d8ccf549531dda"
  license "GPL-2.0-or-later"
  revision 2



  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "f681005415eace664aa7d13f8cfa40bd2f8eba07e50e5a148a4c69c9ad382437"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build
  depends_on "cfitsio"

  def install
    cd "src/C/autotools" do
      system "autoreconf", "--force", "--install", "--verbose"
      system "./configure", "--disable-silent-rules", *std_configure_args
      system "make", "install"
    end

    cd "src/common_libraries/libsharp" do
      system "./configure", "--disable-silent-rules", *std_configure_args
      system "make", "install"
    end

    cd "src/cxx" do
      ENV["SHARP_CFLAGS"] = "-I#{include}"
      ENV["SHARP_LIBS"] = "-L#{lib} -lsharp"
      system "./configure", "--disable-silent-rules", *std_configure_args
      system "make", "install"
    end
  end

  test do
    (testpath/"test.cxx").write <<~CPP
      #include <math.h>
      #include <stdio.h>
      #include "chealpix.h"
      int main(void) {
        long nside, npix, pp, ns1;
        nside = 1024;
        for (pp = 0; pp < 14; pp++) {
          nside = pow(2, pp);
          npix = nside2npix(nside);
          ns1  = npix2nside(npix);
        }
      };
    CPP

    system ENV.cxx, "-o", "test", "test.cxx", "-L#{lib}", "-lchealpix"
    system "./test"
  end
end
