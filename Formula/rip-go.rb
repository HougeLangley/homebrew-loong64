class Rip-go < Formula
  desc "Fuzzy find and kill processes from your terminal with real-time updates"
  homepage "https://example.org/rip-go"
  version "0.2.3"
  url "http://127.0.0.1:8080/brew/bottles/rip-go--0.2.3.loongarch64.bottle.tar.gz"
  sha256 "8ecb31a47e0c06ff982bc12b3007591b1caea6b06438479b17ce15e35e20ce30"

  def install
    bin.install "rip-go"
  end

  test do
    system "#{bin}/rip-go"
  end
end
