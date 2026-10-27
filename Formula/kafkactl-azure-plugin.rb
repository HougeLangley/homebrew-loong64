class Kafkactl-azure-plugin < Formula
  desc "Azure Plugin for kafkactl"
  homepage "https://example.org/kafkactl-azure-plugin"
  version "1.3.1"
  url "http://127.0.0.1:8080/brew/bottles/kafkactl-azure-plugin--1.3.1.loongarch64.bottle.tar.gz"
  sha256 "b554d401285b1e3074782f8886e8062431e84bc0d0e8748750db5db5bbe32ed7"

  def install
    bin.install "kafkactl-azure-plugin"
  end

  test do
    system "#{bin}/kafkactl-azure-plugin"
  end
end
