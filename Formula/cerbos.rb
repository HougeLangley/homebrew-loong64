class Cerbos < Formula
  desc "Cerbos is an open-core authorization management platform for authorizing every identity an"
  homepage "https://example.org/cerbos"
  version "0.57.0"
  url "http://127.0.0.1:8080/brew/bottles/cerbos--0.57.0.loongarch64.bottle.tar.gz"
  sha256 "727495eef31e856eb556bf443cb399d3db4890e2da7d1dfaae96c8c51f78edbe"

  def install
    bin.install "cerbos"
  end

  test do
    system "#{bin}/cerbos"
  end
end
