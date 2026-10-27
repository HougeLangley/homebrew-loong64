class Certstrap < Formula
  desc "Tools to bootstrap CAs, certificate requests, and signed certificates"
  homepage "https://example.org/certstrap"
  version "1.4.1"
  url "http://127.0.0.1:8080/brew/bottles/certstrap--1.4.1.loongarch64.bottle.tar.gz"
  sha256 "48b485d56364dac397fb79e0df751f4bf3108ea2d7686e0d8aff00a9fbae75ee"

  def install
    bin.install "certstrap"
  end

  test do
    system "#{bin}/certstrap"
  end
end
