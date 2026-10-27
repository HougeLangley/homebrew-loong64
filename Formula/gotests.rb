class Gotests < Formula
  desc "Automatically generate Go test boilerplate from your source code"
  homepage "https://example.org/gotests"
  version "1.9.0"
  url "http://127.0.0.1:8080/brew/bottles/gotests--1.9.0.loongarch64.bottle.tar.gz"
  sha256 "b732039c8c5635ea48765a1f46af3ceb25dfab6b52431cfbeadcf9a0bf6318c2"

  def install
    bin.install "gotests"
  end

  test do
    system "#{bin}/gotests"
  end
end
