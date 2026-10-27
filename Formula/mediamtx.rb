class Mediamtx < Formula
  desc "Zero-dependency real-time media server and media proxy"
  homepage "https://example.org/mediamtx"
  version "1.21.3"
  url "http://127.0.0.1:8080/brew/bottles/mediamtx--1.21.3.loongarch64.bottle.tar.gz"
  sha256 "a7e5cd4de76e8884956f0bdbd94267d3c3bd45e1feddc5a9574ded5340b37ea3"

  def install
    bin.install "mediamtx"
  end

  test do
    system "#{bin}/mediamtx"
  end
end
