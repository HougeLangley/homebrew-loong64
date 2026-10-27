class Openbao < Formula
  desc "OpenBao is a software solution to manage, store, and distribute sensitive data including s"
  homepage "https://example.org/openbao"
  version "2.7.2"
  url "http://127.0.0.1:8080/brew/bottles/openbao--2.7.2.loongarch64.bottle.tar.gz"
  sha256 "ade122d700391251ed6ec656bf68966767d88b481909f15dd2d88928b9d70ba4"

  def install
    bin.install "openbao"
  end

  test do
    system "#{bin}/openbao"
  end
end
