class Convox < Formula
  desc "Command-line interface for the Convox PaaS"
  homepage "https://example.org/convox"
  version "3.25.12"
  url "http://127.0.0.1:8080/brew/bottles/convox--3.25.12.loongarch64.bottle.tar.gz"
  sha256 "ceff4fd322cb564b80a49ece897853e513efa922c475c92ba08263917224059b"

  def install
    bin.install "convox"
  end

  test do
    system "#{bin}/convox"
  end
end
