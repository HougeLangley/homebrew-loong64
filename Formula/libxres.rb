class Libxres < Formula
  desc "X.Org: X-Resource extension client library"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/lib/libXres-1.2.3.tar.xz"
  sha256 "d2de8f5401d6c86a8992791654547eb8def585dfdc0c08cc16e24ef6aeeb69dc"
  license "MIT"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "0643ec1bb6e2e4db90ce144e5101a4c4bdd7048858ff1d205594fcafdaf652fc"
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
      #include "X11/extensions/XRes.h"

      int main(int argc, char* argv[]) {
        XResType client;
        return 0;
      }
    C
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lXRes"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
