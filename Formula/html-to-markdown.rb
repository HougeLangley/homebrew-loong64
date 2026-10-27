class Html-to-markdown < Formula
  desc "⚙️ Convert HTML to Markdown. Even works with entire websites and can be extended through r"
  homepage "https://example.org/html-to-markdown"
  version "2.5.2"
  url "http://127.0.0.1:8080/brew/bottles/html-to-markdown--2.5.2.loongarch64.bottle.tar.gz"
  sha256 "1409202cda11692f8e138ae9819aa3e7878ac14f0d4086fc694a2af7d49a22c6"

  def install
    bin.install "html-to-markdown"
  end

  test do
    system "#{bin}/html-to-markdown"
  end
end
