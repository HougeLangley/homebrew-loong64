class Betterglobekey < Formula
  desc "Reworked Globe key for faster input source switching"
  homepage "https://example.org/betterglobekey"
  version "4.2.0"
  url "http://127.0.0.1:8080/brew/bottles/betterglobekey--4.2.0.loongarch64.bottle.tar.gz"
  sha256 "716cab8c71fc18d74857a7f3d7c440e16feeb68f40ca6bd50dfe248ef2d112f6"

  def install
    bin.install "betterglobekey"
  end

  test do
    system "#{bin}/betterglobekey"
  end
end
