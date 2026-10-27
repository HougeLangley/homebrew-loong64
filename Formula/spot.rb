class Spot < Formula
  desc "A user-friendly and efficient tool for the effortless deployment and configuration of reso"
  homepage "https://example.org/spot"
  version "1.20.1"
  url "http://127.0.0.1:8080/brew/bottles/spot--1.20.1.loongarch64.bottle.tar.gz"
  sha256 "517212727227cf68aaf46dd78af78b8ba95be441d1ac3bd40881b7a4d992742e"

  def install
    bin.install "spot"
  end

  test do
    system "#{bin}/spot"
  end
end
