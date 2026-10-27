class Shush < Formula
  desc "Encrypt and decrypt secrets using the AWS Key Management Service"
  homepage "https://example.org/shush"
  version "1.5.5"
  url "http://127.0.0.1:8080/brew/bottles/shush--1.5.5.loongarch64.bottle.tar.gz"
  sha256 "3092368cdb4fffd2c27387597174e61ae64246741d375ece592cf9573e933ffe"

  def install
    bin.install "shush"
  end

  test do
    system "#{bin}/shush"
  end
end
