class Bounceback < Formula
  desc "Stealth redirector for red team operation security"
  homepage "https://example.org/bounceback"
  version "1.5.3"
  url "http://127.0.0.1:8080/brew/bottles/bounceback--1.5.3.loongarch64.bottle.tar.gz"
  sha256 "d80b6aec8a42f8b5b11d5ba943049b0adf3efdf512b1c3e794b3aca6c88a4a3a"

  def install
    bin.install "bounceback"
  end

  test do
    system "#{bin}/bounceback"
  end
end
