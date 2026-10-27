class Docker-agent < Formula
  desc "Agent Builder and Runtime by Docker Engineering"
  homepage "https://example.org/docker-agent"
  version "1.152.0"
  url "http://127.0.0.1:8080/brew/bottles/docker-agent--1.152.0.loongarch64.bottle.tar.gz"
  sha256 "b131811b3d83b340e41932dcd874eb5fd84e58bbc12ff84d9904a0945ef95280"

  def install
    bin.install "docker-agent"
  end

  test do
    system "#{bin}/docker-agent"
  end
end
