class Upterm < Formula
  desc "Instant Terminal Sharing"
  homepage "https://example.org/upterm"
  version "0.40.0"
  url "http://127.0.0.1:8080/brew/bottles/upterm--0.40.0.loongarch64.bottle.tar.gz"
  sha256 "01b2b189470019a9c69873115c6a471c872b0c3a67b385337667ba0e20a5ea15"

  def install
    bin.install "upterm"
  end

  test do
    system "#{bin}/upterm"
  end
end
