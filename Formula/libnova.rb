class Libnova < Formula
  desc "Celestial mechanics, astrometry and astrodynamics library"
  homepage "https://libnova.sourceforge.net/"
  url "https://git.code.sf.net/p/libnova/libnova.git",
      tag:      "v0.16",
      revision: "edbf65abe27ef1a2520eb9e839daaf58f15a6941"
  # libnova is LGPL but the libnovaconfig binary is GPL
  license all_of: ["LGPL-2.0-or-later", "GPL-2.0-or-later"]


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "82c75283e9a536374dfd71b1092726b2a8b1455fe06580354d6efe4b9add2c75"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <libnova/julian_day.h>

      int main(void)
      {
        double JD;

        JD = ln_get_julian_from_sys();
        return 0;
      }
    C

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lnova", "-o", "test"
    system "./test"
  end
end
