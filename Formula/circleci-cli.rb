class Circleci-cli < Formula
  desc "Use CircleCI from the command line"
  homepage "https://example.org/circleci-cli"
  version "1.11.0"
  url "http://127.0.0.1:8080/brew/bottles/circleci-cli--1.11.0.loongarch64.bottle.tar.gz"
  sha256 "4ebd459c13599e4e4d61651c7698e84ba2b557ada844eb3c56f784cd80ea9c41"

  def install
    bin.install "circleci-cli"
  end

  test do
    system "#{bin}/circleci-cli"
  end
end
