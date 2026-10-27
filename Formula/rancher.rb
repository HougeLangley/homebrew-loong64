class Rancher < Formula
  desc "Complete container management platform"
  homepage "https://example.org/rancher"
  version "2.15.2"
  url "http://127.0.0.1:8080/brew/bottles/rancher--2.15.2.loongarch64.bottle.tar.gz"
  sha256 "4394aa2c5ae648cea329edc4af52bbd5f904d506c44c7223e465313eef5f68cd"

  def install
    bin.install "rancher"
  end

  test do
    system "#{bin}/rancher"
  end
end
