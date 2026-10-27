class Apigeecli < Formula
  desc "Apigee management API command-line interface"
  homepage "https://example.org/apigeecli"
  version "2.17.0"
  url "http://127.0.0.1:8080/brew/bottles/apigeecli--2.17.0.loongarch64.bottle.tar.gz"
  sha256 "563bf2a8fc17eaba18951e454a8a853b011f936a51e3ca53cd80dbebbe30e004"

  def install
    bin.install "apigeecli"
  end

  test do
    system "#{bin}/apigeecli"
  end
end
