class Gvm < Formula
  desc "A programming language version manager 🚀 🚀 "
  homepage "https://example.org/gvm"
  version "0.1.1"
  url "http://127.0.0.1:8080/brew/bottles/gvm--0.1.1.loongarch64.bottle.tar.gz"
  sha256 "6834e398edc4e9d0e932c8034c5b4acc712a1b1f19e4b5b0e150b6eece438459"

  def install
    bin.install "gvm"
  end

  test do
    system "#{bin}/gvm"
  end
end
