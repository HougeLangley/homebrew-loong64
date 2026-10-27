class Nap < Formula
  desc "Code snippets in your terminal"
  homepage "https://example.org/nap"
  version "0.1.1"
  url "http://127.0.0.1:8080/brew/bottles/nap--0.1.1.loongarch64.bottle.tar.gz"
  sha256 "eed5389299567bbf3bee870d7312c9259105c645276cc0553a5f5ed068c2f46a"

  def install
    bin.install "nap"
  end

  test do
    system "#{bin}/nap"
  end
end
