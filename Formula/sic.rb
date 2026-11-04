class Sic < Formula
  desc "Minimal multiplexing IRC client"
  homepage "https://tools.suckless.org/sic/"
  url "https://dl.suckless.org/tools/sic-1.3.tar.gz"
  sha256 "30478fab3ebc75f2eb5d08cbb5b2fedcaf489116e75a2dd7197e3e9c733d65d2"
  license "MIT"
  head "https://git.suckless.org/sic/", using: :git, branch: "master"

  livecheck do
    url "https://dl.suckless.org/tools/"
    regex(/href=.*?sic[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  allow_network_access! :test

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ca2b526fc5416254b2d9612bafba1e6710c49f0b43f5e1f1697c3966093d2840"
  end

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    output = shell_output("#{bin}/sic -h 127.0.0.1 -p #{free_port} -n brewbot 2>&1", 1)
    assert_match "cannot connect to host '127.0.0.1'", output
  end
end
