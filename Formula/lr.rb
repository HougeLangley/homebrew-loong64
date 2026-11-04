class Lr < Formula
  desc "File list utility with features from ls(1), find(1), stat(1), and du(1)"
  homepage "https://github.com/leahneukirchen/lr"
  url "https://github.com/leahneukirchen/lr/archive/refs/tags/v2.0.1.tar.gz"
  sha256 "c7c4a57169e1396f17a09b05b19456945c8bb5e55001c5a870b083c0b4a23cd8"
  license "MIT"
  head "https://github.com/leahneukirchen/lr.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "a7c4d011d2f81a30d443d79720d2bd46de32fd0cb188a9e026c82eb32c81abf3"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_match(/^\.\n(.*\n)?\.bazelrc\n/, shell_output("#{bin}/lr -1"))
  end
end
