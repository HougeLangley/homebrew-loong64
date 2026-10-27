class Fluxcd < Formula
  desc "Open and extensible continuous delivery solution for Kubernetes"
  homepage "https://example.org/fluxcd"
  version "2.10.0"
  url "http://127.0.0.1:8080/brew/bottles/fluxcd--2.10.0.loongarch64.bottle.tar.gz"
  sha256 "2d3a9fcd09234c4ea6d22f6da2479bc16a28e967bc3e4bca8e2f832256f7a862"

  def install
    bin.install "fluxcd"
  end

  test do
    system "#{bin}/fluxcd"
  end
end
