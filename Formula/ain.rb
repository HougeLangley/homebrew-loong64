class Ain < Formula
  desc "A HTTP API client for the terminal"
  homepage "https://example.org/ain"
  version "1.6.0"
  url "http://127.0.0.1:8080/brew/bottles/ain--1.6.0.loongarch64.bottle.tar.gz"
  sha256 "ef91f42bd14916423243ee41663dfb3ec6fee53338cabcca27a49aa544ba2d1f"

  def install
    bin.install "ain"
  end

  test do
    system "#{bin}/ain"
  end
end
