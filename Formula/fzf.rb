class Fzf < Formula
  desc "Command-line fuzzy finder"
  homepage "https://example.org/fzf"
  version "0.74.5"
  url "http://127.0.0.1:8080/brew/bottles/fzf--0.74.5.loongarch64.bottle.tar.gz"
  sha256 "02c419de0a877a06bda110fbc1381069a96875bd00b49cb1bba5ed3f16960e99"

  def install
    bin.install "fzf"
  end

  test do
    system "#{bin}/fzf"
  end
end
