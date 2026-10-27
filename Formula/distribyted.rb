class Distribyted < Formula
  desc "Torrent client with HTTP, fuse, and WebDAV interfaces. Start exploring your torrent files "
  homepage "https://example.org/distribyted"
  version "0.15.0"
  url "http://127.0.0.1:8080/brew/bottles/distribyted--0.15.0.loongarch64.bottle.tar.gz"
  sha256 "bdc7000f721b3c6f66779af4473ac158b112c8a7d445365b14e65a9173d8fdf3"

  def install
    bin.install "distribyted"
  end

  test do
    system "#{bin}/distribyted"
  end
end
