class Gron < Formula
  desc "Make JSON greppable"
  homepage "https://example.org/gron"
  version "0.7.1"
  url "http://127.0.0.1:8080/brew/bottles/gron--0.7.1.loongarch64.bottle.tar.gz"
  sha256 "7ee2299a4b18ec822b3a1165302718bb4ace45504840c12a1a3c1c92e0b37f67"

  def install
    bin.install "gron"
  end

  test do
    system "#{bin}/gron"
  end
end
