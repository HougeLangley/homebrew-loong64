class Libice < Formula
  desc "X.Org: Inter-Client Exchange Library"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/lib/libICE-1.1.2.tar.xz"
  sha256 "974e4ed414225eb3c716985df9709f4da8d22a67a2890066bc6dfc89ad298625"
  license "MIT"
  compatibility_version 1


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "2f532e125815f35000c8513794be88c5c213030bbe3f2ead8af4e04a9d69b9aa"
  end

  depends_on "pkgconf" => :build
  depends_on "xtrans" => :build
  depends_on "libx11"=> :test
  depends_on "xorgproto"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |rel|
        src = "/usr/share/libtool/build-aux/#{cf}"
        dest = buildpath/rel
        if dest.exist? && File.exist?(src)
          File.chmod(0644, dest)
          cp src, dest
        end
      end
    end

    args = %W[
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-silent-rules
      --enable-docs=no
      --enable-specs=no
    ]

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args, *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include "X11/Xlib.h"
      #include "X11/ICE/ICEutil.h"

      int main(int argc, char* argv[]) {
        IceAuthFileEntry entry;
        return 0;
      }
    C
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
