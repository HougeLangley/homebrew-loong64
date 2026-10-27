class Uni < Formula
  desc "Unicode database query tool for the command-line"
  homepage "https://example.org/uni"
  version "2.10.0"
  url "http://127.0.0.1:8080/brew/bottles/uni--2.10.0.loongarch64.bottle.tar.gz"
  sha256 "68241f6deb152ade6d6111b4a0cde4bf07954fc66e0d8119e5515522412cf93b"

  def install
    bin.install "uni"
  end

  test do
    system "#{bin}/uni"
  end
end
