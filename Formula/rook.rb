class Rook < Formula
  desc "Storage Orchestration for Kubernetes"
  homepage "https://example.org/rook"
  version "1.21.1"
  url "http://127.0.0.1:8080/brew/bottles/rook--1.21.1.loongarch64.bottle.tar.gz"
  sha256 "057903f366950a8ad154db1c48a71b229dd2ed3abade0e5c834921769150230b"

  def install
    bin.install "rook"
  end

  test do
    system "#{bin}/rook"
  end
end
