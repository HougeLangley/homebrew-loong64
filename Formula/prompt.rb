class Prompt < Formula
  desc "✔ User-friendly, highly customizable interactive prompts for Go."
  homepage "https://example.org/prompt"
  version "0.9.3"
  url "http://127.0.0.1:8080/brew/bottles/prompt--0.9.3.loongarch64.bottle.tar.gz"
  sha256 "40016be58c4e7be136bf96a4f737ace187a299e60a62c3bb945f94025bcf2210"

  def install
    bin.install "prompt"
  end

  test do
    system "#{bin}/prompt"
  end
end
