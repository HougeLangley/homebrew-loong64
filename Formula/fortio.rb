class Fortio < Formula
  desc "Fortio load testing library, command line tool, advanced echo server and web UI in go (gol"
  homepage "https://example.org/fortio"
  version "1.76.0"
  url "http://127.0.0.1:8080/brew/bottles/fortio--1.76.0.loongarch64.bottle.tar.gz"
  sha256 "a9ed5ce53d312b45fee7b0cd30f80ae67f542bdc4a39419eff65bd5fa98e6bdb"

  def install
    bin.install "fortio"
  end

  test do
    system "#{bin}/fortio"
  end
end
