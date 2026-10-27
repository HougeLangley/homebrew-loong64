class Pipeline < Formula
  desc "A cloud-native Pipeline resource."
  homepage "https://example.org/pipeline"
  version "1.17.1"
  url "http://127.0.0.1:8080/brew/bottles/pipeline--1.17.1.loongarch64.bottle.tar.gz"
  sha256 "a21b343b85402ac40ef6de48c4ac3a88a823a7a5bb244cccf5aec6815d4cf467"

  def install
    bin.install "pipeline"
  end

  test do
    system "#{bin}/pipeline"
  end
end
