class Qbittorrent-cli < Formula
  desc "Command-line interface for qBittorrent written in Go"
  homepage "https://example.org/qbittorrent-cli"
  version "2.3.0"
  url "http://127.0.0.1:8080/brew/bottles/qbittorrent-cli--2.3.0.loongarch64.bottle.tar.gz"
  sha256 "99b03e0bc4327dd8976a8f077b208cd4ddf039e880c22ce4bcc1b48a58c1ab80"

  def install
    bin.install "qbittorrent-cli"
  end

  test do
    system "#{bin}/qbittorrent-cli"
  end
end
