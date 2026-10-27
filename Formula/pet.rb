class Pet < Formula
  desc "Simple command-line snippet manager"
  homepage "https://example.org/pet"
  version "1.0.1"
  url "http://127.0.0.1:8080/brew/bottles/pet--1.0.1.loongarch64.bottle.tar.gz"
  sha256 "d454aa332cf2dfe214e201fc7b640ece4fe2337f90ba47738437d06a5966f577"

  def install
    bin.install "pet"
  end

  test do
    system "#{bin}/pet"
  end
end
