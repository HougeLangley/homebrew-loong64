class Nova-fairwinds < Formula
  desc "Find outdated or deprecated Helm charts running in your cluster"
  homepage "https://example.org/nova-fairwinds"
  version "3.12.2"
  url "http://127.0.0.1:8080/brew/bottles/nova-fairwinds--3.12.2.loongarch64.bottle.tar.gz"
  sha256 "47bc7914e511f9609a0db1554542c6da6b7944d6bea82582715480f7bba5ac6d"

  def install
    bin.install "nova-fairwinds"
  end

  test do
    system "#{bin}/nova-fairwinds"
  end
end
