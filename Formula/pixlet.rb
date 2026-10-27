class Pixlet < Formula
  desc "App runtime and UX toolkit for pixel-based apps"
  homepage "https://example.org/pixlet"
  version "0.55.0"
  url "http://127.0.0.1:8080/brew/bottles/pixlet--0.55.0.loongarch64.bottle.tar.gz"
  sha256 "4672b6baf3f6a3991c834f5179e1c125eb28ec0a72fc5af438231c0c53a9a051"

  def install
    bin.install "pixlet"
  end

  test do
    system "#{bin}/pixlet"
  end
end
