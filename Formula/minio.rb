class Minio < Formula
  desc "High Performance, Kubernetes Native Object Storage"
  homepage "https://example.org/minio"
  version "RELEASE.2025-10-15T17-29-55Z"
  url "http://127.0.0.1:8080/brew/bottles/minio--RELEASE.2025-10-15T17-29-55Z.loongarch64.bottle.tar.gz"
  sha256 "219464ade6c2e7f1c79f2659d6c29399ef4d63b603028886696bed97118d0b1f"

  def install
    bin.install "minio"
  end

  test do
    system "#{bin}/minio"
  end
end
