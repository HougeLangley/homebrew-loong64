class Aiac < Formula
  desc "Artificial Intelligence Infrastructure-as-Code Generator"
  homepage "https://example.org/aiac"
  version "5.3.0"
  url "http://127.0.0.1:8080/brew/bottles/aiac--5.3.0.loongarch64.bottle.tar.gz"
  sha256 "918443c5e7efc9c5603743ef12e958c27e81ce332c17e1f350606847437f96ff"

  def install
    bin.install "aiac"
  end

  test do
    system "#{bin}/aiac"
  end
end
