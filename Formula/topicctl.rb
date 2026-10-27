class Topicctl < Formula
  desc "Declarative Kafka topic management"
  homepage "https://example.org/topicctl"
  version "2.0.2"
  url "http://127.0.0.1:8080/brew/bottles/topicctl--2.0.2.loongarch64.bottle.tar.gz"
  sha256 "0307792129f847d18c3082a7558d9a7e750a5e2604d52f538c8df5b91c25fc9b"

  def install
    bin.install "topicctl"
  end

  test do
    system "#{bin}/topicctl"
  end
end
