class Terratag < Formula
  desc "Terratag is a CLI tool that enables users of Terraform to automatically create and maintai"
  homepage "https://example.org/terratag"
  version "0.8.1"
  url "http://127.0.0.1:8080/brew/bottles/terratag--0.8.1.loongarch64.bottle.tar.gz"
  sha256 "970acf72061e2c86f2f3f05a955e94b76cdc30266c554cfe5f5644684847dfbf"

  def install
    bin.install "terratag"
  end

  test do
    system "#{bin}/terratag"
  end
end
