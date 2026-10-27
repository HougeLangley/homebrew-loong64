class Flyctl < Formula
  desc "Command-line tools for fly.io services"
  homepage "https://example.org/flyctl"
  version "0.4.123"
  url "http://127.0.0.1:8080/brew/bottles/flyctl--0.4.123.loongarch64.bottle.tar.gz"
  sha256 "3227959874b5ad143ac32eab9e63f1eeb99c75043fb37a608f62dd631a3103a7"

  def install
    bin.install "flyctl"
  end

  test do
    system "#{bin}/flyctl"
  end
end
