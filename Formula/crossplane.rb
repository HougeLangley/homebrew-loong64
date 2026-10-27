class Crossplane < Formula
  desc "The Cloud Native Control Plane"
  homepage "https://example.org/crossplane"
  version "2.4.3"
  url "http://127.0.0.1:8080/brew/bottles/crossplane--2.4.3.loongarch64.bottle.tar.gz"
  sha256 "4c1bd9939447d6927a5fe354aa1deb56bb14dc9ec21b6e4fea599cbe1c8e5a08"

  def install
    bin.install "crossplane"
  end

  test do
    system "#{bin}/crossplane"
  end
end
