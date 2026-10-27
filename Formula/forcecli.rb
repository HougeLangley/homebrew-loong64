class Forcecli < Formula
  desc "Command-line interface to Force.com"
  homepage "https://example.org/forcecli"
  version "1.13.0"
  url "http://127.0.0.1:8080/brew/bottles/forcecli--1.13.0.loongarch64.bottle.tar.gz"
  sha256 "5a2c263952b26c79106f66e60067e8446ab55e424ea69743472bb937adf32bf2"

  def install
    bin.install "forcecli"
  end

  test do
    system "#{bin}/forcecli"
  end
end
