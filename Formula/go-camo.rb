class Go-camo < Formula
  desc "Secure image proxy server"
  homepage "https://example.org/go-camo"
  version "3.1"
  url "http://127.0.0.1:8080/brew/bottles/go-camo--3.1.loongarch64.bottle.tar.gz"
  sha256 "e3ac580132549feb3e2f62f43ff3e3c0b401673469fe5948469250e1291028f8"

  def install
    bin.install "go-camo"
  end

  test do
    system "#{bin}/go-camo"
  end
end
