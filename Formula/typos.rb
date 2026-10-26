class Typos < Formula
  desc "Source code spell checker"
  homepage "https://example.org/typos"
  version "1.51.1"
  url "http://127.0.0.1:8080/brew/bottles/typos--1.51.1.loongarch64.bottle.tar.gz"
  sha256 "59d76121083407eb121735acb2a0972da2becf902eb2492ff73a65fed5350c76"

  def install
    bin.install "typos"
  end

  test do
    system "#{bin}/typos"
  end
end
