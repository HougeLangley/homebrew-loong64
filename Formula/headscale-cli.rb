class Headscale-cli < Formula
  desc "CLI for headscale, an open-source implementation of the Tailscale control server"
  homepage "https://example.org/headscale-cli"
  version "0.29.6"
  url "http://127.0.0.1:8080/brew/bottles/headscale-cli--0.29.6.loongarch64.bottle.tar.gz"
  sha256 "56aea456afc430b5128dc67ffbd8571a4ffcacaa882401cbbe76dee905b77e18"

  def install
    bin.install "headscale-cli"
  end

  test do
    system "#{bin}/headscale-cli"
  end
end
