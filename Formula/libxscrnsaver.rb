class Libxscrnsaver < Formula
  desc "X.Org: X11 Screen Saver extension client library"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/lib/libXScrnSaver-1.2.5.tar.xz"
  sha256 "5057365f847253e0e275871441e10ff7846c8322a5d88e1e187d326de1cd8d00"
  license "MIT"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "e6b046321770b11e8e9dea51287782f81d68623e08011e8d20c6681e26191f97"
  end

  depends_on "pkgconf" => :build
  depends_on "libx11"
  depends_on "libxext"
  depends_on "xorgproto"

  def install
    args = %W[
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-silent-rules
    ]

    system "./configure", *args, *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include "X11/extensions/scrnsaver.h"

      int main(int argc, char* argv[]) {
        XScreenSaverNotifyEvent event;
        return 0;
      }
    C
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
