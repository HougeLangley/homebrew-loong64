class Lazyspotify < Formula
  desc "Terminal Spotify client for macOS and Linux"
  homepage "https://example.org/lazyspotify"
  version "0.5.2"
  url "http://127.0.0.1:8080/brew/bottles/lazyspotify--0.5.2.loongarch64.bottle.tar.gz"
  sha256 "c79107eba496ab9e4a968469f46bc12cc2a44a3275f2b697fe6bc6696aae5fdf"

  def install
    bin.install "lazyspotify"
  end

  test do
    system "#{bin}/lazyspotify"
  end
end
