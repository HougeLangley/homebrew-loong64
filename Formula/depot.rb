class Depot < Formula
  desc "Build your Docker images in the cloud"
  homepage "https://example.org/depot"
  version "2.103.3"
  url "http://127.0.0.1:8080/brew/bottles/depot--2.103.3.loongarch64.bottle.tar.gz"
  sha256 "4a65d90651eed696f5bfdb78d8496e93efdae70d50297da5dfbcdd384e91796e"

  def install
    bin.install "depot"
  end

  test do
    system "#{bin}/depot"
  end
end
