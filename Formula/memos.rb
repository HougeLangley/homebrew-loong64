class Memos < Formula
  desc "Memos is an open-source, self-hosted note-taking app that brings your everyday thoughts to"
  homepage "https://example.org/memos"
  version "0.31.0"
  url "http://127.0.0.1:8080/brew/bottles/memos--0.31.0.loongarch64.bottle.tar.gz"
  sha256 "22e812195a4216db4ed830b221c128266a1555d41487d753dbf86a4bb915fee2"

  def install
    bin.install "memos"
  end

  test do
    system "#{bin}/memos"
  end
end
