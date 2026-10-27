class Pouch < Formula
  desc "An Efficient Enterprise-class Container Engine"
  homepage "https://example.org/pouch"
  version "1.3.1"
  url "http://127.0.0.1:8080/brew/bottles/pouch--1.3.1.loongarch64.bottle.tar.gz"
  sha256 "7ae83625f48f3816d4bb604da399d7ab2da629a8e230030c13ed051ea1386a2f"

  def install
    bin.install "pouch"
  end

  test do
    system "#{bin}/pouch"
  end
end
