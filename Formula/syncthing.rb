class Syncthing < Formula
  desc "Open source continuous file synchronization application"
  homepage "https://example.org/syncthing"
  version "2.1.7"
  url "http://127.0.0.1:8080/brew/bottles/syncthing--2.1.7.loongarch64.bottle.tar.gz"
  sha256 "3649ac7088f7b5ac8c7bcdf9683b7ef1282df7c0584edcb73135d32aa0df2f6b"

  def install
    bin.install "syncthing"
  end

  test do
    system "#{bin}/syncthing"
  end
end
