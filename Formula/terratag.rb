class Terratag < Formula
  desc "Terratag is a CLI tool that enables users of Terraform to automatically create and maintai"
  homepage "https://example.org/terratag"
  version "0.8.1"
  url "http://127.0.0.1:8080/brew/bottles/terratag--0.8.1.loongarch64.bottle.tar.gz"
  sha256 "ab274323296b9f5f00676fdb9c0bdb7c7ed9bd0730186e24e127c13d83ef9c32"

  def install
    bin.install "terratag"
  end

  test do
    system "#{bin}/terratag"
  end
end
