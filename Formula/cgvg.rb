class Cgvg < Formula
  desc "Command-line source browsing tool"
  homepage "https://github.com/uzi/cgvg"
  url "https://github.com/uzi/cgvg/archive/refs/tags/v1.6.3.tar.gz"
  mirror "https://uzix.org/cgvg/cgvg-1.6.3.tar.gz"
  sha256 "d879f541abcc988841a8d86f0c0781ded6e70498a63c9befdd52baf4649a12f3"
  license "GPL-2.0-or-later"
  head "https://github.com/uzi/cgvg.git", branch: "master"

  bottle do
    rebuild 2
    sha256 cellar: :any_skip_relocation, all: "06ba6e4b8f27a86f39d20fa7d6b0b456d584d9973f15c5a7916145ae46c4d989"
  end

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--mandir=#{man}", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test").write "Homebrew"
    assert_match "1 Homebrew", shell_output("#{bin}/cg Homebrew '#{testpath}/test'")
  end
end
