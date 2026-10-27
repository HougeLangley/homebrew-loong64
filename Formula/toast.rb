class Toast < Formula
  desc "a batteries-included, beautiful, in-terminal IDE"
  homepage "https://example.org/toast"
  version "0.14.0"
  url "http://127.0.0.1:8080/brew/bottles/toast--0.14.0.loongarch64.bottle.tar.gz"
  sha256 "f9b53ae5a789832bf4d06144c9df3fd53ffd05a26236178cbd44a5e5f9a4c6e3"

  def install
    bin.install "toast"
  end

  test do
    system "#{bin}/toast"
  end
end
