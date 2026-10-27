class Go-statik < Formula
  desc "Embed files into a Go executable"
  homepage "https://example.org/go-statik"
  version "0.1.8"
  url "http://127.0.0.1:8080/brew/bottles/go-statik--0.1.8.loongarch64.bottle.tar.gz"
  sha256 "6582c8f6ee4c456b19f216677cdb4895c035c3ed6dce137802c0a4a842e57ee1"

  def install
    bin.install "go-statik"
  end

  test do
    system "#{bin}/go-statik"
  end
end
