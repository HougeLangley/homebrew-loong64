class Unregistry < Formula
  desc "Push docker images directly to remote servers without an external registry"
  homepage "https://example.org/unregistry"
  version "0.4.3"
  url "http://127.0.0.1:8080/brew/bottles/unregistry--0.4.3.loongarch64.bottle.tar.gz"
  sha256 "114edf72903eb58e327d1857388b26113b38c69fb2d1d463a10b4ba14c8906f6"

  def install
    bin.install "unregistry"
  end

  test do
    system "#{bin}/unregistry"
  end
end
