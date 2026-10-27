class Pdf-diff < Formula
  desc "Tool for visualizing differences between two pdf files"
  homepage "https://example.org/pdf-diff"
  version "0.0.1"
  url "http://127.0.0.1:8080/brew/bottles/pdf-diff--0.0.1.loongarch64.bottle.tar.gz"
  sha256 "4e332b585ab79d86292d18999e9aa5476aaebe248ba7d945b5031ae30fa779a8"

  def install
    bin.install "pdf-diff"
  end

  test do
    system "#{bin}/pdf-diff"
  end
end
