class Ktor < Formula
  desc "Generates Ktor projects through the command-line interface"
  homepage "https://example.org/ktor"
  version "0.5.0"
  url "http://127.0.0.1:8080/brew/bottles/ktor--0.5.0.loongarch64.bottle.tar.gz"
  sha256 "a8805c8d14c97f33886d82f001d3da81a6d31ed4b515e7a904ea5445766205cd"

  def install
    bin.install "ktor"
  end

  test do
    system "#{bin}/ktor"
  end
end
