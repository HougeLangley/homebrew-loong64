class Mongodb-atlas-cli < Formula
  desc "Atlas CLI enables you to manage your MongoDB Atlas"
  homepage "https://example.org/mongodb-atlas-cli"
  version "1.59.3"
  url "http://127.0.0.1:8080/brew/bottles/mongodb-atlas-cli--1.59.3.loongarch64.bottle.tar.gz"
  sha256 "be04ae60d789747b6046f4000c896c86966a9bf0cfab7861df18dced18858ead"

  def install
    bin.install "mongodb-atlas-cli"
  end

  test do
    system "#{bin}/mongodb-atlas-cli"
  end
end
