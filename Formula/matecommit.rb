class Matecommit < Formula
  desc "🧉 MateCommit: I built this AI-powered CLI to automate my Git workflow. It generates meanin"
  homepage "https://example.org/matecommit"
  version "1.7.0"
  url "http://127.0.0.1:8080/brew/bottles/matecommit--1.7.0.loongarch64.bottle.tar.gz"
  sha256 "5526940b256af11e489b9b5107008f3d338576cd346cdb9f34c023a482ba58f6"

  def install
    bin.install "matecommit"
  end

  test do
    system "#{bin}/matecommit"
  end
end
