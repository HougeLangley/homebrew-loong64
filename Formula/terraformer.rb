class Terraformer < Formula
  desc "CLI tool to generate terraform files from existing infrastructure"
  homepage "https://example.org/terraformer"
  version "0.8.30"
  url "http://127.0.0.1:8080/brew/bottles/terraformer--0.8.30.loongarch64.bottle.tar.gz"
  sha256 "1c255e10279d654b76b5e4db1d9407ec8642b620e4c413451a0814c57d95c81a"

  def install
    bin.install "terraformer"
  end

  test do
    system "#{bin}/terraformer"
  end
end
