class Cloudnative-pg < Formula
  desc "The most popular Kubernetes Operator for PostgreSQL."
  homepage "https://example.org/cloudnative-pg"
  version "1.30.1"
  url "http://127.0.0.1:8080/brew/bottles/cloudnative-pg--1.30.1.loongarch64.bottle.tar.gz"
  sha256 "902634e6ac3be48f5fe7ea897bb51ba8e19b647f412c9553fbe509238677631e"

  def install
    bin.install "cloudnative-pg"
  end

  test do
    system "#{bin}/cloudnative-pg"
  end
end
