class Kekkai < Formula
  desc "File integrity monitoring tool"
  homepage "https://example.org/kekkai"
  version "0.2.13"
  url "http://127.0.0.1:8080/brew/bottles/kekkai--0.2.13.loongarch64.bottle.tar.gz"
  sha256 "f78dfa7c3bfd60f9a748b2c8073c38b2f66924ca978a322d484fe2f90a6681f4"

  def install
    bin.install "kekkai"
  end

  test do
    system "#{bin}/kekkai"
  end
end
