class Ssllabs-scan < Formula
  desc "This tool is a command-line client for the SSL Labs APIs"
  homepage "https://example.org/ssllabs-scan"
  version "1.4.0"
  url "http://127.0.0.1:8080/brew/bottles/ssllabs-scan--1.4.0.loongarch64.bottle.tar.gz"
  sha256 "df571771c41bc2e2d3ece91300b5ddec56b11606cc7475c5177bfaa7aa96a230"

  def install
    bin.install "ssllabs-scan"
  end

  test do
    system "#{bin}/ssllabs-scan"
  end
end
