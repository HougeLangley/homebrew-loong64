class Calicoctl < Formula
  desc "Calico CLI tool"
  homepage "https://example.org/calicoctl"
  version "3.33.0"
  url "http://127.0.0.1:8080/brew/bottles/calicoctl--3.33.0.loongarch64.bottle.tar.gz"
  sha256 "2a1c577fd8bdcf11da9af386d1c48f3240ef9079627386ccf17ad6ba28701cb6"

  def install
    bin.install "calicoctl"
  end

  test do
    system "#{bin}/calicoctl"
  end
end
