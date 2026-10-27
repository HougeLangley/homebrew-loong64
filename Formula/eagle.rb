class Eagle < Formula
  desc "🦅 A Go framework for the API or Microservice"
  homepage "https://example.org/eagle"
  version "1.11.0"
  url "http://127.0.0.1:8080/brew/bottles/eagle--1.11.0.loongarch64.bottle.tar.gz"
  sha256 "8b801a08faab7398e7204022d7b309f3f9fbe44eab7c6b2824bbbdc5be1dd9e7"

  def install
    bin.install "eagle"
  end

  test do
    system "#{bin}/eagle"
  end
end
