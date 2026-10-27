class Fake-gcs-server < Formula
  desc "Emulator for Google Cloud Storage API"
  homepage "https://example.org/fake-gcs-server"
  version "1.56.1"
  url "http://127.0.0.1:8080/brew/bottles/fake-gcs-server--1.56.1.loongarch64.bottle.tar.gz"
  sha256 "76649d5993fb24bf66219d9c362a3407586cc3494c2bc1a1739f0261d6d6e1c5"

  def install
    bin.install "fake-gcs-server"
  end

  test do
    system "#{bin}/fake-gcs-server"
  end
end
