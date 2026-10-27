class Tsshd < Formula
  desc "UDP-based SSH server with roaming support"
  homepage "https://example.org/tsshd"
  version "0.1.10"
  url "http://127.0.0.1:8080/brew/bottles/tsshd--0.1.10.loongarch64.bottle.tar.gz"
  sha256 "988066a5c73e9af88c07c1ccb46c5a13e3522b20d4b704e79d50b233bb7baa0d"

  def install
    bin.install "tsshd"
  end

  test do
    system "#{bin}/tsshd"
  end
end
