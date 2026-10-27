class Clidle < Formula
  desc "Play Wordle over SSH."
  homepage "https://example.org/clidle"
  version "0.1.0"
  url "http://127.0.0.1:8080/brew/bottles/clidle--0.1.0.loongarch64.bottle.tar.gz"
  sha256 "10d606be54848f011fa68e3af96a1aada7581bcf829b4241fe8bc0075ade246f"

  def install
    bin.install "clidle"
  end

  test do
    system "#{bin}/clidle"
  end
end
