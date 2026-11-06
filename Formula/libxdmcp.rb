class Libxdmcp < Formula
  desc "X.Org: X Display Manager Control Protocol library"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/lib/libXdmcp-1.1.5.tar.xz"
  sha256 "d8a5222828c3adab70adf69a5583f1d32eb5ece04304f7f8392b6a353aa2228c"
  license "MIT"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9d516d84f5027fd564414c1901e250cc9face17626548e8059fd797c133d3147"
  end

  compatibility_version 1


  depends_on "pkgconf" => :build
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
      --enable-docs=no
    ]

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args, *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include "X11/Xdmcp.h"

      int main(int argc, char* argv[]) {
        xdmOpCode code;
        return 0;
      }
    C
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
