class Waves < Formula
  desc "Terminal music player with Soulseek integration, MusicBrainz tagging, Last.fm scrobbling, "
  homepage "https://example.org/waves"
  version "0.1.50"
  url "http://127.0.0.1:8080/brew/bottles/waves--0.1.50.loongarch64.bottle.tar.gz"
  sha256 "f5be884db446a0b793030795873bb63d9cb2b2ff36ca524faf7f5dc616719143"

  def install
    bin.install "waves"
  end

  test do
    system "#{bin}/waves"
  end
end
