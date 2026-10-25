class Delta < Formula
  desc "Syntax-highlighting pager for git and diff output"
  homepage "https://example.org/delta"
  version "0.20.1"
  url "http://127.0.0.1:8080/brew/bottles/delta--0.20.1.loongarch64.bottle.tar.gz"
  sha256 "6fb566f53a0bb67afecb7444a203765e893951c4cdccab2e6984b719261058c1"

  def install
    bin.install "delta"
  end

  test do
    system "#{bin}/delta"
  end
end
