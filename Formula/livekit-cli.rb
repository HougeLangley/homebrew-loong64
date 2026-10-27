class Livekit-cli < Formula
  desc "Command-line interface to LiveKit"
  homepage "https://example.org/livekit-cli"
  version "2.19.2"
  url "http://127.0.0.1:8080/brew/bottles/livekit-cli--2.19.2.loongarch64.bottle.tar.gz"
  sha256 "052fa0da51dcc5f49d828b39ee471a03d75228c443759c40e157d83d7c4e709c"

  def install
    bin.install "livekit-cli"
  end

  test do
    system "#{bin}/livekit-cli"
  end
end
