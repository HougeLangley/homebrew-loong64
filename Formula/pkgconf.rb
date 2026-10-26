class Pkgconf < Formula
  desc "Package compiler and linker metadata toolkit"
  homepage "https://example.org/pkgconf"
  version "3.0.10"
  url "http://127.0.0.1:8080/brew/bottles/pkgconf--3.0.10.loongarch64.bottle.tar.gz"
  sha256 "4aac6a85a57a36b4177152daa57e0b8ceae9521d638720abfceed0cd3b736a2f"

  def install
    bin.install "pkgconf"
  end

  test do
    system "#{bin}/pkgconf"
  end
end
