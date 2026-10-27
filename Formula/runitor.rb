class Runitor < Formula
  desc "Command runner with healthchecks.io integration"
  homepage "https://example.org/runitor"
  version "1.4.1-build.6"
  url "http://127.0.0.1:8080/brew/bottles/runitor--1.4.1-build.6.loongarch64.bottle.tar.gz"
  sha256 "fdae55cd91a23f3849e1f65b8030f92ed948f8a4b607e132174bf48ded379dc9"

  def install
    bin.install "runitor"
  end

  test do
    system "#{bin}/runitor"
  end
end
