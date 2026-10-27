class Tetra < Formula
  desc "Tetragon CLI to observe, manage and troubleshoot Tetragon instances"
  homepage "https://example.org/tetra"
  version "1.7.1"
  url "http://127.0.0.1:8080/brew/bottles/tetra--1.7.1.loongarch64.bottle.tar.gz"
  sha256 "80d718a98af66a9946d1f693cc7c455843e2ff52ca18fe36f72650f8b9a77dfe"

  def install
    bin.install "tetra"
  end

  test do
    system "#{bin}/tetra"
  end
end
