class Twitch-cli < Formula
  desc "CLI to make developing on Twitch easier"
  homepage "https://example.org/twitch-cli"
  version "1.1.24"
  url "http://127.0.0.1:8080/brew/bottles/twitch-cli--1.1.24.loongarch64.bottle.tar.gz"
  sha256 "fc22d88fca533638b006c0f14366a538b3bd4fd5dbdad3e70723ca9cd6bcec0c"

  def install
    bin.install "twitch-cli"
  end

  test do
    system "#{bin}/twitch-cli"
  end
end
