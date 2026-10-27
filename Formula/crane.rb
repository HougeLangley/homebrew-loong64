class Crane < Formula
  desc "Tool for interacting with remote images and registries"
  homepage "https://example.org/crane"
  version "0.22.1"
  url "http://127.0.0.1:8080/brew/bottles/crane--0.22.1.loongarch64.bottle.tar.gz"
  sha256 "2803af8f4195a380f55f2988d8521288ba74637e2be99e35f3f79cefd3ebb6f4"

  def install
    bin.install "crane"
  end

  test do
    system "#{bin}/crane"
  end
end
