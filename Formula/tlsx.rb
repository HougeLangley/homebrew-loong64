class Tlsx < Formula
  desc "Fast and configurable TLS grabber focused on TLS based data collection"
  homepage "https://example.org/tlsx"
  version "1.4.0"
  url "http://127.0.0.1:8080/brew/bottles/tlsx--1.4.0.loongarch64.bottle.tar.gz"
  sha256 "aa33686e117f60b75f1f645944c75e7d46d30fa662cde29ff628f1f97d8320c9"

  def install
    bin.install "tlsx"
  end

  test do
    system "#{bin}/tlsx"
  end
end
