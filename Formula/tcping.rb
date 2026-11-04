class Tcping < Formula
  desc "TCP connect to the given IP/port combo"
  homepage "https://github.com/mkirchner/tcping"
  url "https://github.com/mkirchner/tcping/archive/refs/tags/2.1.0.tar.gz"
  sha256 "b8aa427420fe00173b5a2c0013d78e52b010350f5438bf5903c1942cba7c39c9"
  license "MIT"
  head "https://github.com/mkirchner/tcping.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "47c222a6f4cc3441375f593f70b119882084e8cc4e9a4f50feb78d1e52447019"
  end

  def install
    system "make"
    bin.install "tcping"
  end

  test do
    system bin/"tcping", "www.google.com", "80"
  end
end
