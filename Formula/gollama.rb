class Gollama < Formula
  desc "Go manage your Ollama models"
  homepage "https://example.org/gollama"
  version "2.0.7"
  url "http://127.0.0.1:8080/brew/bottles/gollama--2.0.7.loongarch64.bottle.tar.gz"
  sha256 "2e458c5500d167188fe70574d143c52be2151ee561d4fe3317632a8c4943dd27"

  def install
    bin.install "gollama"
  end

  test do
    system "#{bin}/gollama"
  end
end
