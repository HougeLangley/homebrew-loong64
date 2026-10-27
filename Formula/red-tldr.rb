class Red-tldr < Formula
  desc "Used to help red team staff quickly find the commands and key points"
  homepage "https://example.org/red-tldr"
  version "0.4.3"
  url "http://127.0.0.1:8080/brew/bottles/red-tldr--0.4.3.loongarch64.bottle.tar.gz"
  sha256 "043c6a432bd8924152908b172e0f9e1eeae60b711a45b2af5a5353d91cb6e638"

  def install
    bin.install "red-tldr"
  end

  test do
    system "#{bin}/red-tldr"
  end
end
