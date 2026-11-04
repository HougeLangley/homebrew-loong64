class Libxcomposite < Formula
  desc "X.Org: Client library for the Composite extension"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/lib/libXcomposite-0.4.7.tar.xz"
  sha256 "8bdf310967f484503fa51714cf97bff0723d9b673e0eecbf92b3f97c060c8ccb"
  license "MIT"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "7b2be5162e61008db1c2cb033bf33dcd5703c7c6cce7478c80eb1150ebf87777"
  end

  depends_on "pkgconf" => :build
  depends_on "libx11"
  depends_on "libxfixes"
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
      #include "X11/Xlib.h"
      #include "X11/extensions/Xcomposite.h"

      int main(int argc, char* argv[]) {
        Display *d = NULL;
        int s = DefaultScreen(d);
        Window root = RootWindow(d, s);
        XCompositeReleaseOverlayWindow(d, s);
        return 0;
      }
    C
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lXcomposite"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
