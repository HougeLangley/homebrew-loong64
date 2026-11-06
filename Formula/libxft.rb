class Libxft < Formula
  desc "X.Org: X FreeType library"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/lib/libXft-2.3.9.tar.xz"
  sha256 "60a25b78945ed6932635b3bb1899a517d31df7456e69867ffba27f89ff3976f5"
  license "MIT"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "7bc32a693c274f04226251b86082c391331703e3400b4f111013c2b197cd0a02"
  end

  compatibility_version 1


  depends_on "pkgconf" => :build
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "libx11"
  depends_on "libxrender"

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
      #include "X11/Xft/Xft.h"

      int main(int argc, char* argv[]) {
        XftFont font;
        return 0;
      }
    C
    system ENV.cc, "-I#{formula_opt_include("freetype")}/freetype2", "test.c"
  end
end
