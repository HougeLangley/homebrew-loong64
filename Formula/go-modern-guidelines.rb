class Go-modern-guidelines < Formula
  desc "Help AI coding agents write modern Go"
  homepage "https://example.org/go-modern-guidelines"
  version "0.1.1"
  url "http://127.0.0.1:8080/brew/bottles/go-modern-guidelines--0.1.1.loongarch64.bottle.tar.gz"
  sha256 "456bd63526514a8d57c036d1a4abe2d8066bd5ab7812fdca704da6226a16a741"

  def install
    bin.install "go-modern-guidelines"
  end

  test do
    system "#{bin}/go-modern-guidelines"
  end
end
