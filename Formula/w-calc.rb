class WCalc < Formula
  desc "Very capable calculator"
  homepage "https://w-calc.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/w-calc/Wcalc/2.5/wcalc-2.5.tar.bz2"
  sha256 "0e2c17c20f935328dcdc6cb4c06250a6732f9ee78adf7a55c01133960d6d28ee"
  license "GPL-2.0-or-later"
  revision 1


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "8ae4fb6ec9a5818728ef440ebed78155281191120ee54c8198c80f9539685e0d"
  end

  depends_on "gmp"
  depends_on "mpfr"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Workaround for build with newer clang
    ENV.append_to_cflags "-Wno-incompatible-function-pointer-types" if DevelopmentTools.clang_build_version >= 1500

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    assert_match "4", shell_output("#{bin}/wcalc 2+2")
  end
end
