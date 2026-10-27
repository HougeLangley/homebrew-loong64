class Rain < Formula
  desc "Command-line tool for working with AWS CloudFormation"
  homepage "https://example.org/rain"
  version "1.24.4"
  url "http://127.0.0.1:8080/brew/bottles/rain--1.24.4.loongarch64.bottle.tar.gz"
  sha256 "340d476c3c1d4b14671c4912c758e98c5c1fe278af1bf1faa58223eddcb33857"

  def install
    bin.install "rain"
  end

  test do
    system "#{bin}/rain"
  end
end
