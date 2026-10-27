class Docker-engine < Formula
  desc "Pack, ship and run any application as a lightweight container (Daemon)"
  homepage "https://example.org/docker-engine"
  version "docker-v29.9.2"
  url "http://127.0.0.1:8080/brew/bottles/docker-engine--docker-v29.9.2.loongarch64.bottle.tar.gz"
  sha256 "c7d131dcd2deda3062d0405f76ae3cce13a8c57871689e3f0383ebb2324f5e8f"

  def install
    bin.install "docker-engine"
  end

  test do
    system "#{bin}/docker-engine"
  end
end
