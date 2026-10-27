class Cozypkg < Formula
  desc "CLI for managing Cozystack packages"
  homepage "https://example.org/cozypkg"
  version "1.6.5"
  url "http://127.0.0.1:8080/brew/bottles/cozypkg--1.6.5.loongarch64.bottle.tar.gz"
  sha256 "2d8a0f0f8bbf47703b785b98e2dbf861070bdd905fe6054f75dbdb96e904b5b7"

  def install
    bin.install "cozypkg"
  end

  test do
    system "#{bin}/cozypkg"
  end
end
