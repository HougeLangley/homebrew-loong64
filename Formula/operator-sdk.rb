class Operator-sdk < Formula
  desc "SDK for building Kubernetes applications. Provides high level APIs, useful abstractions, a"
  homepage "https://example.org/operator-sdk"
  version "1.42.3"
  url "http://127.0.0.1:8080/brew/bottles/operator-sdk--1.42.3.loongarch64.bottle.tar.gz"
  sha256 "40db8dda9e8e592c319247f080d27fa48e565dc174f008319761a0e122f8dedf"

  def install
    bin.install "operator-sdk"
  end

  test do
    system "#{bin}/operator-sdk"
  end
end
