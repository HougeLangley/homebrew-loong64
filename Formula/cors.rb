class Cors < Formula
  desc "perhaps the best CORS middleware library for Go"
  homepage "https://example.org/cors"
  version "1.2.0"
  url "http://127.0.0.1:8080/brew/bottles/cors--1.2.0.loongarch64.bottle.tar.gz"
  sha256 "b23ce15a39b9de408e11f9a1129ca6a51139c037acd86e145003f0dd56b6e0cf"

  def install
    bin.install "cors"
  end

  test do
    system "#{bin}/cors"
  end
end
