class Github-markdown-toc < Formula
  desc "Easy TOC creation for GitHub README.md (in go)"
  homepage "https://example.org/github-markdown-toc"
  version "2.0.1"
  url "http://127.0.0.1:8080/brew/bottles/github-markdown-toc--2.0.1.loongarch64.bottle.tar.gz"
  sha256 "db57acbb0aec3b47dce7890fb444676a6881f4fbc53ced22f8f3f80c16ca0e90"

  def install
    bin.install "github-markdown-toc"
  end

  test do
    system "#{bin}/github-markdown-toc"
  end
end
