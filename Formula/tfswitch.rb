class Tfswitch < Formula
  desc "Command-line tool to switch between Terraform versions"
  homepage "https://example.org/tfswitch"
  version "1.20.0"
  url "http://127.0.0.1:8080/brew/bottles/tfswitch--1.20.0.loongarch64.bottle.tar.gz"
  sha256 "604b1a2e9af3b572e3d39b259f860e724445c93063a8cc14df0005cc786f2c86"

  def install
    bin.install "tfswitch"
  end

  test do
    system "#{bin}/tfswitch"
  end
end
