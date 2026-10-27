class Autobrr < Formula
  desc "Modern, easy to use download automation for torrents and usenet."
  homepage "https://example.org/autobrr"
  version "1.89.0"
  url "http://127.0.0.1:8080/brew/bottles/autobrr--1.89.0.loongarch64.bottle.tar.gz"
  sha256 "01212be29bf34c6c2ee3ceaa7a4eac0cab89da6abc69e1bde25bc98a32bb6a92"

  def install
    bin.install "autobrr"
  end

  test do
    system "#{bin}/autobrr"
  end
end
