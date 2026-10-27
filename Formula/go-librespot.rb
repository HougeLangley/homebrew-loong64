class Go-librespot < Formula
  desc "Spotify client"
  homepage "https://example.org/go-librespot"
  version "0.10.5"
  url "http://127.0.0.1:8080/brew/bottles/go-librespot--0.10.5.loongarch64.bottle.tar.gz"
  sha256 "dc0d1de3ebf796697027531b71888291307a3ea57d8aab4a23331e9254f38bee"

  def install
    bin.install "go-librespot"
  end

  test do
    system "#{bin}/go-librespot"
  end
end
