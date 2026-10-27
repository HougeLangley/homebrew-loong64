class Akku < Formula
  desc "Package manager for Scheme"
  homepage "https://example.org/akku"
  version "1.2.0"
  url "http://127.0.0.1:8080/brew/bottles/akku--1.2.0.loongarch64.bottle.tar.gz"
  sha256 "c9c8aee5c7972a98e40d03def257256429ed4641ff30dd866bf2ce4fddb4c79f"

  def install
    bin.install "akku"
  end

  test do
    system "#{bin}/akku"
  end
end
