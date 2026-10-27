class Kumo < Formula
  desc "A lightweight AWS service emulator written in Go"
  homepage "https://example.org/kumo"
  version "0.33.1"
  url "http://127.0.0.1:8080/brew/bottles/kumo--0.33.1.loongarch64.bottle.tar.gz"
  sha256 "d6c875b1e6899f5f425aeec8829ba78c6177de412e9ef3c3d81e5e0f59109eed"

  def install
    bin.install "kumo"
  end

  test do
    system "#{bin}/kumo"
  end
end
