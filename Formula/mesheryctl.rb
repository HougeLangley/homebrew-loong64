class Mesheryctl < Formula
  desc "Command-line utility for Meshery, the cloud native management plane"
  homepage "https://example.org/mesheryctl"
  version "1.0.74"
  url "http://127.0.0.1:8080/brew/bottles/mesheryctl--1.0.74.loongarch64.bottle.tar.gz"
  sha256 "a9049baa11ed84f5c030a07e5c4b15b83fb532266abec229d9b19d2d2f3abdfe"

  def install
    bin.install "mesheryctl"
  end

  test do
    system "#{bin}/mesheryctl"
  end
end
