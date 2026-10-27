class Nats-streaming-server < Formula
  desc "Lightweight cloud messaging system"
  homepage "https://example.org/nats-streaming-server"
  version "0.25.6"
  url "http://127.0.0.1:8080/brew/bottles/nats-streaming-server--0.25.6.loongarch64.bottle.tar.gz"
  sha256 "7c311cad6e5ef3c407d65566ac8944b67c42adfd6a70922ac8b7bccfe3d23884"

  def install
    bin.install "nats-streaming-server"
  end

  test do
    system "#{bin}/nats-streaming-server"
  end
end
