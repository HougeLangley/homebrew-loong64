class Cadence < Formula
  desc "Resource-oriented smart contract programming language"
  homepage "https://example.org/cadence"
  version "1.10.6"
  url "http://127.0.0.1:8080/brew/bottles/cadence--1.10.6.loongarch64.bottle.tar.gz"
  sha256 "e9fddaeec7f64a7093dafe6ffcff42752c280d0d4b6d37d7e5015e136b259b15"

  def install
    bin.install "cadence"
  end

  test do
    system "#{bin}/cadence"
  end
end
