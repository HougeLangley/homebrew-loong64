class Tables-to-go < Formula
  desc "Easily convert your database tables to structs."
  homepage "https://example.org/tables-to-go"
  version "2.13.0"
  url "http://127.0.0.1:8080/brew/bottles/tables-to-go--2.13.0.loongarch64.bottle.tar.gz"
  sha256 "8bb00b6afa5f29aff212543095c46df6d0a2357ec0c22589248a29514cfcd93f"

  def install
    bin.install "tables-to-go"
  end

  test do
    system "#{bin}/tables-to-go"
  end
end
