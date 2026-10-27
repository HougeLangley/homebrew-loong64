class Conmon < Formula
  desc "OCI container runtime monitor"
  homepage "https://example.org/conmon"
  version "2.2.1"
  url "http://127.0.0.1:8080/brew/bottles/conmon--2.2.1.loongarch64.bottle.tar.gz"
  sha256 "5e6fd1cacc4540a26debe488353dbd37f26b517486be6cdb5e1c6f6d25f775f9"

  def install
    bin.install "conmon"
  end

  test do
    system "#{bin}/conmon"
  end
end
