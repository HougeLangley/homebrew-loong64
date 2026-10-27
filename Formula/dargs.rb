class Dargs < Formula
  desc "Enhance any command with dynamic arguments"
  homepage "https://example.org/dargs"
  version "0.0.2"
  url "http://127.0.0.1:8080/brew/bottles/dargs--0.0.2.loongarch64.bottle.tar.gz"
  sha256 "f653b8a47dc071b0e8c5f25b6ceeb48c9ecb81d3abda6290597fdacbd2472e81"

  def install
    bin.install "dargs"
  end

  test do
    system "#{bin}/dargs"
  end
end
