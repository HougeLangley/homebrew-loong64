class Spicetify-cli < Formula
  desc "Command-line tool to customize Spotify client"
  homepage "https://example.org/spicetify-cli"
  version "2.46.4"
  url "http://127.0.0.1:8080/brew/bottles/spicetify-cli--2.46.4.loongarch64.bottle.tar.gz"
  sha256 "f9c82edf63b7103613e1585bf6649c0ccb7633af4b3e624e1b3e5f7f3f5f0de5"

  def install
    bin.install "spicetify-cli"
  end

  test do
    system "#{bin}/spicetify-cli"
  end
end
