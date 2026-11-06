class Libxext < Formula
  desc "X.Org: Library for common extensions to the X11 protocol"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/lib/libXext-1.3.7.tar.gz"
  sha256 "6564608dc3b816b0cfddf0c7ddc62bc579055dd70b2f28113a618df2acb64189"
  license "MIT"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "36dcc3f59996b71a7b76d6fa6700f45636227320642e30bdac7c21ba017e3401"
  end

  compatibility_version 1


  depends_on "pkgconf" => :build
  depends_on "libx11"
  depends_on "xorgproto"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = %W[
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-silent-rules
      --enable-specs=no
    ]

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args, *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include "X11/extensions/shape.h"

      int main(int argc, char* argv[]) {
        XShapeEvent event;
        return 0;
      }
    C
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
