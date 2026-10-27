class Muffet < Formula
  desc "Fast website link checker in Go"
  homepage "https://example.org/muffet"
  version "2.11.7"
  url "http://127.0.0.1:8080/brew/bottles/muffet--2.11.7.loongarch64.bottle.tar.gz"
  sha256 "6eb04158bc0a6b4eb74764d631f877e0df6908b46574128b025a5788cd5bf122"

  def install
    bin.install "muffet"
  end

  test do
    system "#{bin}/muffet"
  end
end
