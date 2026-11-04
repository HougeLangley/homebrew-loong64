class Libxt < Formula
  desc "X.Org: X Toolkit Intrinsics library"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/lib/libXt-1.3.1.tar.xz"
  sha256 "e0a774b33324f4d4c05b199ea45050f87206586d81655f8bef4dba434d931288"
  license "MIT"
  compatibility_version 1


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "5b900f146f39cc6d1d06defc9a26f9e1570ad4025a52ae2c7cd01825467b5f3b"
  end

  depends_on "pkgconf" => :build
  depends_on "libice"
  depends_on "libsm"
  depends_on "libx11"

  def install
    args = %W[
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --with-appdefaultdir=#{etc}/X11/app-defaults
      --disable-silent-rules
      --disable-specs
    ]

    system "./configure", *args, *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include "X11/IntrinsicP.h"
      #include "X11/CoreP.h"

      int main(int argc, char* argv[]) {
        CoreClassPart *range;
        return 0;
      }
    C
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
