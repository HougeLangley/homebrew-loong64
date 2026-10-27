class Seaweedfs < Formula
  desc "SeaweedFS is a distributed storage system for object storage (S3), file systems, and Icebe"
  homepage "https://example.org/seaweedfs"
  version "4.51"
  url "http://127.0.0.1:8080/brew/bottles/seaweedfs--4.51.loongarch64.bottle.tar.gz"
  sha256 "bbe6884ae8c2c8ecc65a8640d067b8fc161667b3fc944099a8715caa4d6283f5"

  def install
    bin.install "seaweedfs"
  end

  test do
    system "#{bin}/seaweedfs"
  end
end
