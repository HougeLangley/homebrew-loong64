class Kafkactl-aws-plugin < Formula
  desc "AWS Plugin for kafkactl"
  homepage "https://example.org/kafkactl-aws-plugin"
  version "1.3.1"
  url "http://127.0.0.1:8080/brew/bottles/kafkactl-aws-plugin--1.3.1.loongarch64.bottle.tar.gz"
  sha256 "28593c285b5caf4fcfa9952d96266c42daeebec90a146e0785faffb7bada23de"

  def install
    bin.install "kafkactl-aws-plugin"
  end

  test do
    system "#{bin}/kafkactl-aws-plugin"
  end
end
