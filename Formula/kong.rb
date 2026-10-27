class Kong < Formula
  desc "Kong is a command-line parser for Go"
  homepage "https://example.org/kong"
  version "1.16.1"
  url "http://127.0.0.1:8080/brew/bottles/kong--1.16.1.loongarch64.bottle.tar.gz"
  sha256 "88ff6b2654ba4b27d0803533deaf15174a7d1aa64c5517019dd247b5a62e5f77"

  def install
    bin.install "kong"
  end

  test do
    system "#{bin}/kong"
  end
end
