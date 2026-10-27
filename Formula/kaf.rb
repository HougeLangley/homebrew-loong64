class Kaf < Formula
  desc "Modern CLI for Apache Kafka"
  homepage "https://example.org/kaf"
  version "0.2.14"
  url "http://127.0.0.1:8080/brew/bottles/kaf--0.2.14.loongarch64.bottle.tar.gz"
  sha256 "011ca9db4430b68eb322b8dd68892cd03dfe4bb7a89bbe67c5292ca2fc8a802a"

  def install
    bin.install "kaf"
  end

  test do
    system "#{bin}/kaf"
  end
end
