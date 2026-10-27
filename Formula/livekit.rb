class Livekit < Formula
  desc "Scalable, high-performance WebRTC server"
  homepage "https://example.org/livekit"
  version "1.13.11"
  url "http://127.0.0.1:8080/brew/bottles/livekit--1.13.11.loongarch64.bottle.tar.gz"
  sha256 "0d46b1daba68f0897738eb615909b0e02736d73b091770528fb3b627c2570403"

  def install
    bin.install "livekit"
  end

  test do
    system "#{bin}/livekit"
  end
end
