class Gickup < Formula
  desc "gickup for loongarch64"
  homepage "https://example.org/gickup"
  version "0.10.47"
  url "http://127.0.0.1:8080/brew/bottles/gickup--0.10.47.loongarch64.bottle.tar.gz"
  sha256 "90283ec7019cf02ddbf0f41dde937a7392d5bc70eea1e1fccc0763ec89bbcdba"

  def install
    bin.install "gickup"
  end

  test do
    system "#{bin}/gickup"
  end
end
