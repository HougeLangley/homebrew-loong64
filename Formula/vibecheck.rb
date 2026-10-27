class Vibecheck < Formula
  desc "Vibecheck is a lightweight, cross-platform command line AI-tool that automatically generat"
  homepage "https://example.org/vibecheck"
  version "1.7.7"
  url "http://127.0.0.1:8080/brew/bottles/vibecheck--1.7.7.loongarch64.bottle.tar.gz"
  sha256 "18ae66331dc81d3f809582b8ccfacbb378ac9c5e193a8f09c5a5d210c6466093"

  def install
    bin.install "vibecheck"
  end

  test do
    system "#{bin}/vibecheck"
  end
end
