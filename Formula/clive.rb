class Clive < Formula
  desc "⚡ Automates terminal operations."
  homepage "https://example.org/clive"
  version "0.12.17"
  url "http://127.0.0.1:8080/brew/bottles/clive--0.12.17.loongarch64.bottle.tar.gz"
  sha256 "63565f23c75d4235e535f5f567b8bd83442f1f6b403eeb4dfad00c11cdac241b"

  def install
    bin.install "clive"
  end

  test do
    system "#{bin}/clive"
  end
end
