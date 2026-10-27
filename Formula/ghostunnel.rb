class Ghostunnel < Formula
  desc "A simple TLS proxy with mutual authentication for securing non-TLS services."
  homepage "https://example.org/ghostunnel"
  version "1.11.5"
  url "http://127.0.0.1:8080/brew/bottles/ghostunnel--1.11.5.loongarch64.bottle.tar.gz"
  sha256 "246ccea0ba7464f6fece821067724193f5adf9ffd772990a0679770e279a06ca"

  def install
    bin.install "ghostunnel"
  end

  test do
    system "#{bin}/ghostunnel"
  end
end
