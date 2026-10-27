class Uncloud < Formula
  desc "A lightweight tool for deploying and managing containerised applications across a network "
  homepage "https://example.org/uncloud"
  version "0.21.0"
  url "http://127.0.0.1:8080/brew/bottles/uncloud--0.21.0.loongarch64.bottle.tar.gz"
  sha256 "8b43e4935f3054027b6889579084d40776a6be1645f9a7a3787777839dae1e83"

  def install
    bin.install "uncloud"
  end

  test do
    system "#{bin}/uncloud"
  end
end
