class Termshark < Formula
  desc "Terminal UI for tshark, inspired by Wireshark"
  homepage "https://example.org/termshark"
  version "2.4.0"
  url "http://127.0.0.1:8080/brew/bottles/termshark--2.4.0.loongarch64.bottle.tar.gz"
  sha256 "ac71018970e54248448c00b461b9c8766372567e316aa440ef9b3532f939b30e"

  def install
    bin.install "termshark"
  end

  test do
    system "#{bin}/termshark"
  end
end
