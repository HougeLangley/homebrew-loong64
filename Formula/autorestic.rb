class Autorestic < Formula
  desc "Config driven, easy backup cli for restic."
  homepage "https://example.org/autorestic"
  version "1.8.3"
  url "http://127.0.0.1:8080/brew/bottles/autorestic--1.8.3.loongarch64.bottle.tar.gz"
  sha256 "6b46adf7b8950939f03b5f52b7cfab2ec6832957c3f5829d59ac670f475dd49e"

  def install
    bin.install "autorestic"
  end

  test do
    system "#{bin}/autorestic"
  end
end
