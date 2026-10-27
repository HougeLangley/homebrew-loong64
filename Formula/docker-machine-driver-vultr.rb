class Docker-machine-driver-vultr < Formula
  desc "Docker Machine driver plugin for Vultr Cloud"
  homepage "https://example.org/docker-machine-driver-vultr"
  version "2.3.0"
  url "http://127.0.0.1:8080/brew/bottles/docker-machine-driver-vultr--2.3.0.loongarch64.bottle.tar.gz"
  sha256 "bb706b8f92d65b497d6d1e1f2524d1e5acd77a24e82be6694cdea1b383ba31cc"

  def install
    bin.install "docker-machine-driver-vultr"
  end

  test do
    system "#{bin}/docker-machine-driver-vultr"
  end
end
