class Cozyhr < Formula
  desc "Cozy wrapper around Helm and Flux CD for local development"
  homepage "https://example.org/cozyhr"
  version "1.6.1"
  url "http://127.0.0.1:8080/brew/bottles/cozyhr--1.6.1.loongarch64.bottle.tar.gz"
  sha256 "adc39c7fa1c899bea1fbf4c95ccb9abbee5b6c407f3a0beb6e81ccd4af6f479a"

  def install
    bin.install "cozyhr"
  end

  test do
    system "#{bin}/cozyhr"
  end
end
