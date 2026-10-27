class Cdebug < Formula
  desc "Swiss army knife of container debugging"
  homepage "https://example.org/cdebug"
  version "0.0.19"
  url "http://127.0.0.1:8080/brew/bottles/cdebug--0.0.19.loongarch64.bottle.tar.gz"
  sha256 "86d02d4dcc06dfab24d25332682a3092795ed5f5cc8ea25660340cf2bb087a88"

  def install
    bin.install "cdebug"
  end

  test do
    system "#{bin}/cdebug"
  end
end
