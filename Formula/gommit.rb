class Gommit < Formula
  desc "Enforce git message commit consistency"
  homepage "https://example.org/gommit"
  version "2.13.0"
  url "http://127.0.0.1:8080/brew/bottles/gommit--2.13.0.loongarch64.bottle.tar.gz"
  sha256 "d9e3479e3d811a9bcc19bd3ecd921a0f97df8f8477f57fca853e0b1872fba3f5"

  def install
    bin.install "gommit"
  end

  test do
    system "#{bin}/gommit"
  end
end
