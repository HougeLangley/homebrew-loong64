class Microsocks < Formula
  desc "Tiny, portable SOCKS5 server with very moderate resource usage"
  homepage "https://github.com/rofl0r/microsocks"
  url "https://github.com/rofl0r/microsocks/archive/refs/tags/v1.0.5.tar.gz"
  sha256 "939d1851a18a4c03f3cc5c92ff7a50eaf045da7814764b4cb9e26921db15abc8"
  license "MIT"
  head "https://github.com/rofl0r/microsocks.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "1286977c0bed96ccb9c1d747f31b6e90a205230c43674559a21886493968577c"
  end

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    port = free_port
    spawn bin/"microsocks", "-p", port.to_s
    sleep 2
    output = shell_output("curl --socks5 0.0.0.0:#{port} https://brew.sh")
    assert_match "The Package Manager for Everywhere", output
  end
end
