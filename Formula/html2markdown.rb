class Html2markdown < Formula
  desc "Convert HTML to Markdown"
  homepage "https://example.org/html2markdown"
  version "2.5.2"
  url "http://127.0.0.1:8080/brew/bottles/html2markdown--2.5.2.loongarch64.bottle.tar.gz"
  sha256 "527738ad720b33edd48b2202073a32e1c1fac951983e1050eef44443a775ebb5"

  def install
    bin.install "html2markdown"
  end

  test do
    system "#{bin}/html2markdown"
  end
end
