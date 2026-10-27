class Xz < Formula
  desc "XZ Utils compression tool"
  homepage "https://example.org/xz"
  version "5.8.4"
  url "http://127.0.0.1:8080/brew/bottles/xz--5.8.4.loongarch64.bottle.tar.gz"
  sha256 "18af498c930a0ddfbd0804223cc1795d5737a6be37f3b4484cb21082aad9deaf"

  def install
    bin.install "xz"
  end

  test do
    system "#{bin}/xz"
  end
end
