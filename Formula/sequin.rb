class Sequin < Formula
  desc "Human-readable ANSI sequences"
  homepage "https://example.org/sequin"
  version "0.3.1"
  url "http://127.0.0.1:8080/brew/bottles/sequin--0.3.1.loongarch64.bottle.tar.gz"
  sha256 "b4937763e0ff675024dd1640f642d67be0544ef0f569204296d4bd91ae3de280"

  def install
    bin.install "sequin"
  end

  test do
    system "#{bin}/sequin"
  end
end
