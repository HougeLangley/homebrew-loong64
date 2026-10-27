class Pulsarctl < Formula
  desc "CLI for Apache Pulsar written in Go"
  homepage "https://example.org/pulsarctl"
  version "4.2.5.2"
  url "http://127.0.0.1:8080/brew/bottles/pulsarctl--4.2.5.2.loongarch64.bottle.tar.gz"
  sha256 "28fed041208c068fd0a6fc2e8683db064111ff95c0c502377193c90ab6ded769"

  def install
    bin.install "pulsarctl"
  end

  test do
    system "#{bin}/pulsarctl"
  end
end
