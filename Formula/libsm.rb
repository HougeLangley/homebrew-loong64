class Libsm < Formula
  desc "X.Org: X Session Management Library"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/lib/libSM-1.2.6.tar.xz"
  sha256 "be7c0abdb15cbfd29ac62573c1c82e877f9d4047ad15321e7ea97d1e43d835be"
  license "MIT"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "dd34fdba13d23d577e065f131217f043038c468f07b5bbeaf17ba1e198dbeecf"
  end

  compatibility_version 1


  depends_on "pkgconf" => :build
  depends_on "xtrans" => :build
  depends_on "libice"

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
      #include "X11/SM/SMlib.h"

      int main(int argc, char* argv[]) {
        SmProp prop;
        return 0;
      }
    C
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
