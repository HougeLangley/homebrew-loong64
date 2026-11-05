class Usbredir < Formula
  desc "USB traffic redirection library"
  homepage "https://www.spice-space.org"
  url "https://www.spice-space.org/download/usbredir/usbredir-0.15.0.tar.xz"
  sha256 "6dc2a380277688a068191245dac2ab7063a552999d8ac3ad8e841c10ff050961"
  license all_of: ["GPL-2.0-or-later", "LGPL-2.0-or-later"]

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "45d17276f05087759d1f6849a7ee58d23b9dd08fda029219ae02d289fb3c3333"
  end

  livecheck do
    url "https://www.spice-space.org/download/usbredir/"
    regex(/href=.*?usbredir[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end



  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  depends_on "glib"
  depends_on "libusb"

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <usbredirparser.h>
      int main() {
        return usbredirparser_create() ? 0 : 1;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-lusbredirparser", "-o", "test"
    system "./test"
  end
end
