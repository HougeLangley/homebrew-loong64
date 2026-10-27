class Stripe-cli < Formula
  desc "Command-line tool for Stripe"
  homepage "https://example.org/stripe-cli"
  version "1.55.2"
  url "http://127.0.0.1:8080/brew/bottles/stripe-cli--1.55.2.loongarch64.bottle.tar.gz"
  sha256 "3299984adc1befbac093783815e2d1b88dea718c536d7ee520120eddb7cf11f5"

  def install
    bin.install "stripe-cli"
  end

  test do
    system "#{bin}/stripe-cli"
  end
end
