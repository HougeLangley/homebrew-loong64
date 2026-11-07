class Microsocks < Formula
  desc "Tiny, portable SOCKS5 server with very moderate resource usage"
  homepage "https://github.com/rofl0r/microsocks"
  url "https://github.com/rofl0r/microsocks/archive/refs/tags/v1.0.5.tar.gz"
  sha256 "939d1851a18a4c03f3cc5c92ff7a50eaf045da7814764b4cb9e26921db15abc8"
  license "MIT"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "39b97a787823a0989615a3ab62e5515c427e61610b634d8a96f2e0ddf2895952"
  end

  head "https://github.com/rofl0r/microsocks.git", branch: "master"



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
