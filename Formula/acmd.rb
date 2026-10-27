class Acmd < Formula
  desc "Simple, useful and opinionated CLI package in Go."
  homepage "https://example.org/acmd"
  version "0.12.0"
  url "http://127.0.0.1:8080/brew/bottles/acmd--0.12.0.loongarch64.bottle.tar.gz"
  sha256 "cfee8281e21ec79a834385785d42ad727a462e20ba23fa8c228fd8f08ded64eb"

  def install
    bin.install "acmd"
  end

  test do
    system "#{bin}/acmd"
  end
end
