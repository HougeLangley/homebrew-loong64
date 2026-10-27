class Authelia < Formula
  desc "The Single Sign-On Multi-Factor portal for web apps. OpenID Certified™ and Post-Quantum Cr"
  homepage "https://example.org/authelia"
  version "4.39.28"
  url "http://127.0.0.1:8080/brew/bottles/authelia--4.39.28.loongarch64.bottle.tar.gz"
  sha256 "818162f937ec73cc4bb56640aea739bcf2ebe0e9bbc12b1f48033792cb1f0c3c"

  def install
    bin.install "authelia"
  end

  test do
    system "#{bin}/authelia"
  end
end
