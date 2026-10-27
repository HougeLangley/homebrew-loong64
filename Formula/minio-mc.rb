class Minio-mc < Formula
  desc "Replacement for ls, cp and other commands for object storage"
  homepage "https://example.org/minio-mc"
  version "RELEASE.2025-08-13T08-35-41Z"
  url "http://127.0.0.1:8080/brew/bottles/minio-mc--RELEASE.2025-08-13T08-35-41Z.loongarch64.bottle.tar.gz"
  sha256 "4d85a2fa9c26a29a9e1122791627297a79535fd5a3bdf99322d03b66c6f3dee9"

  def install
    bin.install "minio-mc"
  end

  test do
    system "#{bin}/minio-mc"
  end
end
