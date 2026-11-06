class Nettoe < Formula
  desc "Tic Tac Toe-like game for the console"
  homepage "https://nettoe.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/nettoe/nettoe/1.5.1/nettoe-1.5.1.tar.gz"
  sha256 "dbc2c08e7e0f7e60236954ee19a165a350ab3e0bcbbe085ecd687f39253881cb"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "7cb42f17bc8637cc32c498328f75d2a8a1f0b453af74e0b6b5026363d3ad5aa2"
  end


  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Work around failure from GCC 10+ using default of `-fno-common`
    # multiple definition of `addrfamily'; nettoe.o:(.bss+0x68): first defined here
    # multiple definition of `NO_COLORS'; nettoe.o:(.bss+0x64): first defined here
    # multiple definition of `NO_BEEP'; nettoe.o:(.bss+0x60): first defined here
    ENV.append_to_cflags "-fcommon" if OS.linux?

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    assert_match "netToe #{version} ", shell_output("#{bin}/nettoe -v")
  end
end
