class Ast-grep < Formula
  desc "Structural search and rewrite"
  homepage "https://example.org/ast-grep"
  version "0.51.0"
  url "http://127.0.0.1:8080/brew/bottles/ast-grep--0.51.0.loongarch64.bottle.tar.gz"
  sha256 "f528a9ebd100bc64205b7a43654350814907dbd493bf4d19933c3c4f9f63a0c6"

  def install
    bin.install "ast-grep"
  end

  test do
    system "#{bin}/ast-grep"
  end
end
