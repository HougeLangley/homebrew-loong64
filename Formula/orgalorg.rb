class Orgalorg < Formula
  desc "Parallel SSH commands executioner and file synchronization tool"
  homepage "https://example.org/orgalorg"
  version "1.3.1"
  url "http://127.0.0.1:8080/brew/bottles/orgalorg--1.3.1.loongarch64.bottle.tar.gz"
  sha256 "2bfaf0ef60c1f759a03c046de2c5dc86302b3b758d1248520081de9cadc4fb20"

  def install
    bin.install "orgalorg"
  end

  test do
    system "#{bin}/orgalorg"
  end
end
