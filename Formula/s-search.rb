class S-search < Formula
  desc "Web search from the terminal"
  homepage "https://example.org/s-search"
  version "0.8.1"
  url "http://127.0.0.1:8080/brew/bottles/s-search--0.8.1.loongarch64.bottle.tar.gz"
  sha256 "50ef9a63a33a80dad45d8f55a13a75d016441dc7d660616a58a6defb29881d1f"

  def install
    bin.install "s-search"
  end

  test do
    system "#{bin}/s-search"
  end
end
