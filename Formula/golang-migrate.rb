class Golang-migrate < Formula
  desc "Database migrations CLI tool"
  homepage "https://example.org/golang-migrate"
  version "4.20.1"
  url "http://127.0.0.1:8080/brew/bottles/golang-migrate--4.20.1.loongarch64.bottle.tar.gz"
  sha256 "473b7bd3f309f05a77367f23a334cec568fde418ecfa4b81b417d533e00093dd"

  def install
    bin.install "golang-migrate"
  end

  test do
    system "#{bin}/golang-migrate"
  end
end
