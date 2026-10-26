class Htop < Formula
  desc "Interactive process viewer"
  homepage "https://example.org/htop"
  version "3.5.3"
  url "http://127.0.0.1:8080/brew/bottles/htop--3.5.3.loongarch64.bottle.tar.gz"
  sha256 "e4d635c5d83b4c11e0a88632ee0202e31b7f9c549181d694f42df6de2ef476f7"

  def install
    bin.install "htop"
  end

  test do
    system "#{bin}/htop"
  end
end
