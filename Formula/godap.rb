class Godap < Formula
  desc "A complete terminal user interface (TUI) for LDAP."
  homepage "https://example.org/godap"
  version "2.12.2"
  url "http://127.0.0.1:8080/brew/bottles/godap--2.12.2.loongarch64.bottle.tar.gz"
  sha256 "e0542abc8e3d29d4c554e06d3887730fd56a5f34793573ab245cde3642aa881f"

  def install
    bin.install "godap"
  end

  test do
    system "#{bin}/godap"
  end
end
