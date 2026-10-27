class Ipinfo-cli < Formula
  desc "Official CLI for the IPinfo IP Address API"
  homepage "https://example.org/ipinfo-cli"
  version "ipinfo-3.3.3"
  url "http://127.0.0.1:8080/brew/bottles/ipinfo-cli--ipinfo-3.3.3.loongarch64.bottle.tar.gz"
  sha256 "62eaeb604f66e7f679cf728f47339a1a55e734e5c0375a18eaf9fea0c1762f67"

  def install
    bin.install "ipinfo-cli"
  end

  test do
    system "#{bin}/ipinfo-cli"
  end
end
