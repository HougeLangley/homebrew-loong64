class Conduit < Formula
  desc "Streams data between data stores. Kafka Connect replacement. No JVM required"
  homepage "https://example.org/conduit"
  version "0.21.2"
  url "http://127.0.0.1:8080/brew/bottles/conduit--0.21.2.loongarch64.bottle.tar.gz"
  sha256 "ae62d15da27b0bf717144f27fd1e211b666b4ab186344791b834b389cb79cef7"

  def install
    bin.install "conduit"
  end

  test do
    system "#{bin}/conduit"
  end
end
