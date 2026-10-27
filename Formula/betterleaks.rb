class Betterleaks < Formula
  desc "Find leaked secrets everywhere."
  homepage "https://example.org/betterleaks"
  version "1.9.0"
  url "http://127.0.0.1:8080/brew/bottles/betterleaks--1.9.0.loongarch64.bottle.tar.gz"
  sha256 "35de8a6003cc73c1ba73b8cfe6a8ef05232c8793379480808f6b085e45659f05"

  def install
    bin.install "betterleaks"
  end

  test do
    system "#{bin}/betterleaks"
  end
end
