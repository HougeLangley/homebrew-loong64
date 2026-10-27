class Go-gituser < Formula
  desc "Switch between git accounts easily"
  homepage "https://example.org/go-gituser"
  version "1.8.0"
  url "http://127.0.0.1:8080/brew/bottles/go-gituser--1.8.0.loongarch64.bottle.tar.gz"
  sha256 "bfb4b34857d785f8d7599b7442afa0078f883157bab5f4f0e656d77b3d14fa8f"

  def install
    bin.install "go-gituser"
  end

  test do
    system "#{bin}/go-gituser"
  end
end
