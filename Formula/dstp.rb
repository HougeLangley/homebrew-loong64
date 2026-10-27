class Dstp < Formula
  desc "Run common networking tests against your site"
  homepage "https://example.org/dstp"
  version "0.4.23"
  url "http://127.0.0.1:8080/brew/bottles/dstp--0.4.23.loongarch64.bottle.tar.gz"
  sha256 "f4c2f233d46361521adedf760833ef929606bcaee9d96840b0fe1ee5330bf727"

  def install
    bin.install "dstp"
  end

  test do
    system "#{bin}/dstp"
  end
end
