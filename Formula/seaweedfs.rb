class Seaweedfs < Formula
  desc "SeaweedFS is a distributed storage system for object storage (S3), file systems, and Icebe"
  homepage "https://example.org/seaweedfs"
  version "4.51"
  url "http://127.0.0.1:8080/brew/bottles/seaweedfs--4.51.loongarch64.bottle.tar.gz"
  sha256 "d78d56f0e07ef27e470f37daa549bdafaa9f3972e4567accd09a42e73c9f938d"

  def install
    bin.install "seaweedfs"
  end

  test do
    system "#{bin}/seaweedfs"
  end
end
