class Swctl < Formula
  desc "Apache SkyWalking CLI (Command-line Interface)"
  homepage "https://example.org/swctl"
  version "0.15.0"
  url "http://127.0.0.1:8080/brew/bottles/swctl--0.15.0.loongarch64.bottle.tar.gz"
  sha256 "a801481e3759d3c39f5a6039285a6cc18111f7f3353143d37a33104899fdf81c"

  def install
    bin.install "swctl"
  end

  test do
    system "#{bin}/swctl"
  end
end
