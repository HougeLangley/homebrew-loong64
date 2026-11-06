class Z80dasm < Formula
  desc "Disassembler for the Zilog Z80 microprocessor and compatibles"
  homepage "https://www.tablix.org/~avian/blog/articles/z80dasm/"
  url "https://www.tablix.org/~avian/z80dasm/z80dasm-1.2.0.tar.gz"
  mirror "https://geeklan.co.uk/files/z80dasm-1.2.0.tar.gz"
  sha256 "8da2c4a58a3917a8229dec0da97e718f90ede84985424d74456575bf5acfeec8"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://www.tablix.org/~avian/z80dasm/"
    regex(/href=.*?z80dasm[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d2a9db35a20e9242a8a4ccafbdd8b8f668671f3b12b39d1e9333c1a70750ed51"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    path = testpath/"a.bin"
    path.binwrite [0xcd, 0x34, 0x12].pack("c*")
    assert_match "call 01234h", shell_output("#{bin}/z80dasm #{path}")
  end
end
