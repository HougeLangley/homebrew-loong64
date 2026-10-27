class Asciinema < Formula
  desc "Terminal session recorder, streamer and player 📹"
  homepage "https://example.org/asciinema"
  version "3.2.1"
  url "http://127.0.0.1:8080/brew/bottles/asciinema--3.2.1.loongarch64.bottle.tar.gz"
  sha256 "eccfcd2771c6e695022f0da865d735066d6e6a132500c5d2638bf060aa51130f"

  def install
    bin.install "asciinema"
  end

  test do
    system "#{bin}/asciinema"
  end
end
