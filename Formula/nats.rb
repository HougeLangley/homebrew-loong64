class Nats < Formula
  desc "Utility for NATS Server and JetStream administration"
  homepage "https://example.org/nats"
  version "0.5.1"
  url "http://127.0.0.1:8080/brew/bottles/nats--0.5.1.loongarch64.bottle.tar.gz"
  sha256 "4f5c4fe9788d25681175d762ffcd62cd519e4f23e352b8d1ebc96d5a01cddf40"

  def install
    bin.install "nats"
  end

  test do
    system "#{bin}/nats"
  end
end
