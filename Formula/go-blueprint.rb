class Go-blueprint < Formula
  desc "CLI to streamline Go project setup with standardized structure"
  homepage "https://example.org/go-blueprint"
  version "0.10.11"
  url "http://127.0.0.1:8080/brew/bottles/go-blueprint--0.10.11.loongarch64.bottle.tar.gz"
  sha256 "ddee6e7d55352f22b49209a9d9973515259057e27b80314d4ba842b43aa9de0d"

  def install
    bin.install "go-blueprint"
  end

  test do
    system "#{bin}/go-blueprint"
  end
end
