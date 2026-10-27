class Pkgsite < Formula
  desc "Documentation server for Go packages"
  homepage "https://example.org/pkgsite"
  version "0.6.0"
  url "http://127.0.0.1:8080/brew/bottles/pkgsite--0.6.0.loongarch64.bottle.tar.gz"
  sha256 "8f59fe10ff6500f7159abee878aff7da5fb2a5224438fff4acdeb55f20146fc6"

  def install
    bin.install "pkgsite"
  end

  test do
    system "#{bin}/pkgsite"
  end
end
