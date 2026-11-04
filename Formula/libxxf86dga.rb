class Libxxf86dga < Formula
  desc "X.Org: XFree86-DGA X extension"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/lib/libXxf86dga-1.1.7.tar.xz"
  sha256 "b3be5b444d324cb6e0f4b5019a4972c99ea336ccb8ab7968eccefecd917ffde6"
  license "MIT"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "b7d6090717842e98e16f20f9b923f8a74f3300576594bfb11a45b0fe9a85f708"
  end

  depends_on "pkgconf" => :build
  depends_on "xorgproto" => :build
  depends_on "libx11"
  depends_on "libxext"

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
      #include "X11/Xlib.h"
      #include "X11/extensions/Xxf86dga.h"

      int main(int argc, char* argv[]) {
        XDGAEvent event;
        return 0;
      }
    C
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
