class Grimoire < Formula
  desc "🧙 Grimoire is a skills package manager for AI agents and best practices — 1000+ skills acr"
  homepage "https://example.org/grimoire"
  version "0.2.0"
  url "http://127.0.0.1:8080/brew/bottles/grimoire--0.2.0.loongarch64.bottle.tar.gz"
  sha256 "13c814e3d2d88dbefe68be98ab5a770f07d80195020b279f3a59cc701e5720eb"

  def install
    bin.install "grimoire"
  end

  test do
    system "#{bin}/grimoire"
  end
end
