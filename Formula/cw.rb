class Cw < Formula
  desc "The best way to tail AWS CloudWatch Logs from your terminal"
  homepage "https://example.org/cw"
  version "4.1.3"
  url "http://127.0.0.1:8080/brew/bottles/cw--4.1.3.loongarch64.bottle.tar.gz"
  sha256 "5b65e85bf8b6f28b6f246f1da51df79c3ce16aae1ebb83ae5594fdc52cfca93b"

  def install
    bin.install "cw"
  end

  test do
    system "#{bin}/cw"
  end
end
