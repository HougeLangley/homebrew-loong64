class Heksa < Formula
  desc "CLI hex dumper with colors"
  homepage "https://example.org/heksa"
  version "1.14.0"
  url "http://127.0.0.1:8080/brew/bottles/heksa--1.14.0.loongarch64.bottle.tar.gz"
  sha256 "0b4b23fc0fe9316281daeff41dd9cd8a20fa20fd39cde52930c981d546e2cb89"

  def install
    bin.install "heksa"
  end

  test do
    system "#{bin}/heksa"
  end
end
