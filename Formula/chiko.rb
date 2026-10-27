class Chiko < Formula
  desc "Ultimate Beauty gRPC Client for your Terminal"
  homepage "https://example.org/chiko"
  version "0.2.0"
  url "http://127.0.0.1:8080/brew/bottles/chiko--0.2.0.loongarch64.bottle.tar.gz"
  sha256 "07b06492ea321a398a8cf6aa427db27bf21bd0935cdb448523060f9e2b58e241"

  def install
    bin.install "chiko"
  end

  test do
    system "#{bin}/chiko"
  end
end
