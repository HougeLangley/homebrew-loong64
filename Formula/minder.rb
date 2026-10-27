class Minder < Formula
  desc "CLI for interacting with Stacklok's Minder platform"
  homepage "https://example.org/minder"
  version "0.3.2"
  url "http://127.0.0.1:8080/brew/bottles/minder--0.3.2.loongarch64.bottle.tar.gz"
  sha256 "94d995d64f07689284d2d434defe831951e206032858958fddcc3b4ac2772689"

  def install
    bin.install "minder"
  end

  test do
    system "#{bin}/minder"
  end
end
