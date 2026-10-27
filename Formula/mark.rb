class Mark < Formula
  desc "Sync your markdown files with Confluence pages."
  homepage "https://example.org/mark"
  version "16.24.0"
  url "http://127.0.0.1:8080/brew/bottles/mark--16.24.0.loongarch64.bottle.tar.gz"
  sha256 "6ddf2ea518acdb9dd51ae41b144b313ddc57ad5d5781b0a9b7388c1b046c399b"

  def install
    bin.install "mark"
  end

  test do
    system "#{bin}/mark"
  end
end
