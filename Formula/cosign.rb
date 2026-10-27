class Cosign < Formula
  desc "Container Signing"
  homepage "https://example.org/cosign"
  version "3.1.4"
  url "http://127.0.0.1:8080/brew/bottles/cosign--3.1.4.loongarch64.bottle.tar.gz"
  sha256 "54291b7e8737189bec7ffaa96fa50d0f18e33298349fdccfde8b25148b963734"

  def install
    bin.install "cosign"
  end

  test do
    system "#{bin}/cosign"
  end
end
