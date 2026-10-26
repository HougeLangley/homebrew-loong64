class Mdcat < Formula
  desc "Markdown renderer for the terminal"
  homepage "https://example.org/mdcat"
  version "2.7.1"
  url "http://127.0.0.1:8080/brew/bottles/mdcat--2.7.1.loongarch64.bottle.tar.gz"
  sha256 "5fd5cbcf1c5136e8d1ed7e2439ea529875c98ec3a6f6a4b4267a09a6baa21150"

  def install
    bin.install "mdcat"
  end

  test do
    system "#{bin}/mdcat"
  end
end
