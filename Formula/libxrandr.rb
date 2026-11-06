class Libxrandr < Formula
  desc "X.Org: X Resize, Rotate and Reflection extension library"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/lib/libXrandr-1.5.5.tar.xz"
  sha256 "72b922c2e765434e9e9f0960148070bd4504b288263e2868a4ccce1b7cf2767a"
  license "MIT"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "07349eac5734113398ea87fd34ca82411acce0460588ab453b930d7fa95675b6"
  end

  compatibility_version 1


  depends_on "pkgconf" => :build
  depends_on "libx11"
  depends_on "libxext"
  depends_on "libxrender"
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
    ]

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args, *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include "X11/Xlib.h"
      #include "X11/extensions/Xrandr.h"

      int main(int argc, char* argv[]) {
        XRRScreenSize size;
        return 0;
      }
    C
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
