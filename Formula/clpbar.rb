class Clpbar < Formula
  desc "Command-line progress bar"
  homepage "https://clpbar.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/clpbar/clpbar/bar-1.11.1/bar_1.11.1.tar.gz"
  sha256 "fa0f5ec5c8400316c2f4debdc6cdcb80e186e668c2e4471df4fec7bfcd626503"
  license "GPL-2.0-or-later"


  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "6a4c844ce28595adbdff5c32c5c6a29050da90da462a31ee5a0e2393476c2413"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", "--program-prefix='clp'", *args, *std_configure_args
    system "make", "install"
  end

  test do
    output = pipe_output("#{bin}/clpbar 2>&1", shell_output("dd if=/dev/zero bs=1024 count=5"))
    assert_match "Copied: 5120B (5.0KB)", output
  end
end
