class Gotenberg < Formula
  desc "A developer-friendly API for converting many document formats into PDF files, and more!"
  homepage "https://example.org/gotenberg"
  version "8.38.1"
  url "http://127.0.0.1:8080/brew/bottles/gotenberg--8.38.1.loongarch64.bottle.tar.gz"
  sha256 "afb2b18d002d377b1eec3fc9643334ecc69a9e0ac5476bb6a0984c55a3c2d574"

  def install
    bin.install "gotenberg"
  end

  test do
    system "#{bin}/gotenberg"
  end
end
