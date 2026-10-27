class Ghq < Formula
  desc "Remote repository management made easy"
  homepage "https://example.org/ghq"
  version "1.11.2"
  url "http://127.0.0.1:8080/brew/bottles/ghq--1.11.2.loongarch64.bottle.tar.gz"
  sha256 "ecac3e27cb2e6992e70e81692d7e5afa58f2be1cc8732f218ba64350a8a20aa7"

  def install
    bin.install "ghq"
  end

  test do
    system "#{bin}/ghq"
  end
end
