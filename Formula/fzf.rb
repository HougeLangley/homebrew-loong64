class Fzf < Formula
  desc "Command-line fuzzy finder"
  homepage "https://example.org/fzf"
  version "0.74.5"
  url "http://127.0.0.1:8080/brew/bottles/fzf--0.74.5.loongarch64.bottle.tar.gz"
  sha256 "adcc7a15e53fb1e7f1c6acce117b4246c823b2f80f37d4e708022837c2a73b8b"

  def install
    bin.install "fzf"
  end

  test do
    system "#{bin}/fzf"
  end
end
