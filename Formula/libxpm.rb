class Libxpm < Formula
  desc "X.Org: X Pixmap (XPM) image file format library"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/lib/libXpm-3.5.20.tar.gz"
  sha256 "736704d843459abbf769560ff8e443a5de4e6023082e7086c9d195253ada17ff"
  license "MIT"
  compatibility_version 1


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "5e16d78c9cadfa76e48725245e3b24f14345ba55b9d60318666a046c32d60222"
  end

  depends_on "gettext" => :build
  depends_on "pkgconf" => :build
  depends_on "libx11"

  on_macos do
    depends_on "gettext"
  end

  def install
    args = %W[
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-open-zfile
      --disable-silent-rules
      --disable-stat-zfile
    ]

    system "./configure", *args, *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include "X11/Xlib.h"
      #include "X11/xpm.h"

      int main(int argc, char* argv[]) {
        XpmColor color;
        return 0;
      }
    C
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
