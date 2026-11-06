class Libxtst < Formula
  desc "X.Org: Client API for the XTEST & RECORD extensions"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/lib/libXtst-1.2.6.tar.gz"
  sha256 "f30f2d4f8370077de9f35220a539bf34c042ca02a55669a4d8f345c661ce7839"
  license "MIT"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "f9ad9a3e87b1e891f79e1a097043fd860e9f1181dc8a5396d93071f19d542ec5"
  end

  compatibility_version 1


  depends_on "pkgconf" => :build
  depends_on "util-macros" => :build

  depends_on "libx11"
  depends_on "libxext"
  depends_on "libxi"
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
      #include "X11/Xlib.h"
      #include "X11/extensions/record.h"

      int main(int argc, char* argv[]) {
        XRecordRange8 *range;
        return 0;
      }
    C
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
