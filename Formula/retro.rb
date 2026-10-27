class Retro < Formula
  desc "📼 play musics with command line on linux"
  homepage "https://example.org/retro"
  version "0.0.46"
  url "http://127.0.0.1:8080/brew/bottles/retro--0.0.46.loongarch64.bottle.tar.gz"
  sha256 "431ebb44ba0a2ee0728ac4b48728cf74d39b2041b629f72c019f363028462d91"

  def install
    bin.install "retro"
  end

  test do
    system "#{bin}/retro"
  end
end
