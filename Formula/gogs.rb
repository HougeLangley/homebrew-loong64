class Gogs < Formula
  desc "The painless way to host your own Git service"
  homepage "https://example.org/gogs"
  version "0.14.3"
  url "http://127.0.0.1:8080/brew/bottles/gogs--0.14.3.loongarch64.bottle.tar.gz"
  sha256 "582c4abff35150d04557af5596b97716e0777a7c7479f39eaa2cfb02d97e0e66"

  def install
    bin.install "gogs"
  end

  test do
    system "#{bin}/gogs"
  end
end
