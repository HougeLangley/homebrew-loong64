class Hami < Formula
  desc "Heterogeneous GPU Sharing on Kubernetes"
  homepage "https://example.org/hami"
  version "2.10.0"
  url "http://127.0.0.1:8080/brew/bottles/hami--2.10.0.loongarch64.bottle.tar.gz"
  sha256 "f2afa46d5e496393042a223c2dcf9e3be028e2c42699a0184cf5c8039d2280d7"

  def install
    bin.install "hami"
  end

  test do
    system "#{bin}/hami"
  end
end
