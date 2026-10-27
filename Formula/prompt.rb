class Prompt < Formula
  desc "✔ User-friendly, highly customizable interactive prompts for Go."
  homepage "https://example.org/prompt"
  version "0.9.3"
  url "http://127.0.0.1:8080/brew/bottles/prompt--0.9.3.loongarch64.bottle.tar.gz"
  sha256 "105392e61ab0b1c6340f3bd64881b311e664ff9a8bb1f87c3f940ac2e7963e9e"

  def install
    bin.install "prompt"
  end

  test do
    system "#{bin}/prompt"
  end
end
