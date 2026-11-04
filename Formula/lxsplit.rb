class Lxsplit < Formula
  desc "Tool for splitting or joining files"
  homepage "https://lxsplit.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/lxsplit/lxsplit/0.2.4/lxsplit-0.2.4.tar.gz"
  sha256 "858fa939803b2eba97ccc5ec57011c4f4b613ff299abbdc51e2f921016845056"
  license "GPL-2.0-or-later"


  deprecate! date: "2026-07-17", because: :unmaintained
  disable! date: "2027-01-17", because: :unmaintained

  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "a8856765601c0e6f5d99d7113f863aa0260f0a64193685abb6d054f25dd81a01"
  end

  def install
    bin.mkpath
    inreplace "Makefile", "/usr/local/bin", bin
    system "make"
    system "make", "install"
  end

  test do
    data = (0...3000).map { |i| (i % 251).chr }.join
    (testpath/"data.bin").binwrite data

    output = shell_output("#{bin}/lxsplit -s data.bin 1k")
    assert_match "Splitting data.bin into 3 pieces.", output
    assert_equal 1024, (testpath/"data.bin.001").size
    assert_equal 952, (testpath/"data.bin.003").size

    rm "data.bin"
    output = shell_output("#{bin}/lxsplit -j data.bin.001")
    assert_match "Complete size: 3000 in 3 files.", output
    assert_equal data, (testpath/"data.bin").binread
  end
end
