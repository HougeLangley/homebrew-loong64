class Minio-warp < Formula
  desc "S3 benchmarking tool"
  homepage "https://example.org/minio-warp"
  version "1.8.2"
  url "http://127.0.0.1:8080/brew/bottles/minio-warp--1.8.2.loongarch64.bottle.tar.gz"
  sha256 "ab4eb0902c45f533bb844fa0cc8c5852f62ed6ff5888349f70ad33acdea97e53"

  def install
    bin.install "minio-warp"
  end

  test do
    system "#{bin}/minio-warp"
  end
end
