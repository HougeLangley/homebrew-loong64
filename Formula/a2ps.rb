class A2ps < Formula
  desc "Any-to-PostScript filter"
  homepage "https://example.org/a2ps"
  version "4.15.8"
  url "http://127.0.0.1:8080/brew/bottles/a2ps--4.15.8.loongarch64.bottle.tar.gz"
  sha256 "bf2fe2cad37a537e3fa90e0f400abf556027332d9185e516f0ba8c0d11529112"

  def install
    bin.install "a2ps"
  end

  test do
    system "#{bin}/a2ps"
  end
end
