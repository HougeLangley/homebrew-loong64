class Awk < Formula
  desc "Text processing scripting language"
  homepage "https://www.cs.princeton.edu/~bwk/btl.mirror/"
  url "https://github.com/onetrueawk/awk/archive/refs/tags/20260426.tar.gz"
  sha256 "7ae5b9fc6a8149bc45ea0ba3ba434a69a16d1460d19f6d01b6f04cc885b8e02b"
  license "SMLNJ"
  head "https://github.com/onetrueawk/awk.git", branch: "master"


  uses_from_macos "bison" => :build

  on_linux do
    conflicts_with "gawk", because: "both install an `awk` executable"
  end

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "b0afd24da31b5d53e039d2280e666d09ec39d550c06a62b77a7c6ebb68c180ed"
  end

  def install
    system "make", "CC=#{ENV.cc}", "CFLAGS=#{ENV.cflags}"
    bin.install "a.out" => "awk"
    man1.install "awk.1"
  end

  test do
    assert_match "test", pipe_output("#{bin}/awk '{print $1}'", "test", 0)
  end
end
