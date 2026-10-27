class Jwtauth < Formula
  desc "JWT authentication middleware for Go HTTP services"
  homepage "https://example.org/jwtauth"
  version "5.4.0"
  url "http://127.0.0.1:8080/brew/bottles/jwtauth--5.4.0.loongarch64.bottle.tar.gz"
  sha256 "01a7472ee1b32e38e06341050891168e196529c7c779b59e2beb032e3a8ea2e1"

  def install
    bin.install "jwtauth"
  end

  test do
    system "#{bin}/jwtauth"
  end
end
