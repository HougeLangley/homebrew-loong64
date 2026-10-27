class Addlicense < Formula
  desc "Scan directories recursively to ensure source files have license headers"
  homepage "https://example.org/addlicense"
  version "1.2.0"
  url "http://127.0.0.1:8080/brew/bottles/addlicense--1.2.0.loongarch64.bottle.tar.gz"
  sha256 "9fc8e9edd0aab8ec5a01591cd7469b68521cff92e92e76a682d3d1a9d59e64a4"

  def install
    bin.install "addlicense"
  end

  test do
    system "#{bin}/addlicense"
  end
end
