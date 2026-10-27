class Lean-cli < Formula
  desc "Command-line tool to develop and manage LeanCloud apps"
  homepage "https://example.org/lean-cli"
  version "1.2.4"
  url "http://127.0.0.1:8080/brew/bottles/lean-cli--1.2.4.loongarch64.bottle.tar.gz"
  sha256 "1cc7e7e447917a182576c82f654035b3bf564aca91e2af208b7131ef7622e890"

  def install
    bin.install "lean-cli"
  end

  test do
    system "#{bin}/lean-cli"
  end
end
