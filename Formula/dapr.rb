class Dapr < Formula
  desc "Dapr is a portable runtime for building distributed applications across cloud and edge, co"
  homepage "https://example.org/dapr"
  version "1.19.0"
  url "http://127.0.0.1:8080/brew/bottles/dapr--1.19.0.loongarch64.bottle.tar.gz"
  sha256 "8ddbfdd562d715388397981672bedf2d020afe45839db682ad4aee7bc6415ec7"

  def install
    bin.install "dapr"
  end

  test do
    system "#{bin}/dapr"
  end
end
