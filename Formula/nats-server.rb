class Nats-server < Formula
  desc "Lightweight cloud messaging system"
  homepage "https://example.org/nats-server"
  version "2.15.2"
  url "http://127.0.0.1:8080/brew/bottles/nats-server--2.15.2.loongarch64.bottle.tar.gz"
  sha256 "fdc2ea6186afcaf784d32c984d45f2d80fd90d5bf4f4a584baa646c32b65b895"

  def install
    bin.install "nats-server"
  end

  test do
    system "#{bin}/nats-server"
  end
end
