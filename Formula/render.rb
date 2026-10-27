class Render < Formula
  desc "Command-line interface for Render"
  homepage "https://example.org/render"
  version "2.32.0"
  url "http://127.0.0.1:8080/brew/bottles/render--2.32.0.loongarch64.bottle.tar.gz"
  sha256 "9d3f89597a1a5323979a99c39f4d12709b2719631528da88bdd655a2a294d3a8"

  def install
    bin.install "render"
  end

  test do
    system "#{bin}/render"
  end
end
