class Imaginary < Formula
  desc "Fast, simple, scalable, Docker-ready HTTP microservice for high-level image processing"
  homepage "https://example.org/imaginary"
  version "1.2.4"
  url "http://127.0.0.1:8080/brew/bottles/imaginary--1.2.4.loongarch64.bottle.tar.gz"
  sha256 "8c9d1a25f21127c20442138bd97047fd9cd4358a0c769de8294738e79d550f8b"

  def install
    bin.install "imaginary"
  end

  test do
    system "#{bin}/imaginary"
  end
end
