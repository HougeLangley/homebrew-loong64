class Moby < Formula
  desc "The Moby Project - a collaborative project for the container ecosystem to assemble contain"
  homepage "https://example.org/moby"
  version "docker-v29.9.2"
  url "http://127.0.0.1:8080/brew/bottles/moby--docker-v29.9.2.loongarch64.bottle.tar.gz"
  sha256 "3fe5f82d62a0669882e1b8523bc30190da68b588078e5031f245125ce3fc4e1c"

  def install
    bin.install "moby"
  end

  test do
    system "#{bin}/moby"
  end
end
