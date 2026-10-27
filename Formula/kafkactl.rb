class Kafkactl < Formula
  desc "CLI for managing Apache Kafka"
  homepage "https://example.org/kafkactl"
  version "5.21.0"
  url "http://127.0.0.1:8080/brew/bottles/kafkactl--5.21.0.loongarch64.bottle.tar.gz"
  sha256 "91f6992954ec0a5251fd477976fb92438afd27568990e8b02cd3bbe10fb40059"

  def install
    bin.install "kafkactl"
  end

  test do
    system "#{bin}/kafkactl"
  end
end
