class Fzshell < Formula
  desc "Fuzzy shell completions you didn't know you needed"
  homepage "https://example.org/fzshell"
  version "0.5.2"
  url "http://127.0.0.1:8080/brew/bottles/fzshell--0.5.2.loongarch64.bottle.tar.gz"
  sha256 "bbcc598d3a968b9d83f6278d8b3135bc92fe1f921fb01eb335b058001e35e574"

  def install
    bin.install "fzshell"
  end

  test do
    system "#{bin}/fzshell"
  end
end
