class S3git < Formula
  desc "s3git: git for Cloud Storage. Distributed Version Control for Data. Create decentralized a"
  homepage "https://example.org/s3git"
  version "0.9.2"
  url "http://127.0.0.1:8080/brew/bottles/s3git--0.9.2.loongarch64.bottle.tar.gz"
  sha256 "2887f20a5520ada146aaa02756bea5eddc69347b0cbc97b7b7bde0148bd0689d"

  def install
    bin.install "s3git"
  end

  test do
    system "#{bin}/s3git"
  end
end
