class Circleci < Formula
  desc "Official command-line tool for CircleCI"
  homepage "https://example.org/circleci"
  version "1.11.0"
  url "http://127.0.0.1:8080/brew/bottles/circleci--1.11.0.loongarch64.bottle.tar.gz"
  sha256 "f63d8beb549f281afc6dbc07af964789e5d679e38be1368fe1c56061e8e2b675"

  def install
    bin.install "circleci"
  end

  test do
    system "#{bin}/circleci"
  end
end
