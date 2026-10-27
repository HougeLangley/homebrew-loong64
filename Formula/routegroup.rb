class Routegroup < Formula
  desc "Lightweight library for route grouping and middleware integration with the standard http.S"
  homepage "https://example.org/routegroup"
  version "1.6.1"
  url "http://127.0.0.1:8080/brew/bottles/routegroup--1.6.1.loongarch64.bottle.tar.gz"
  sha256 "bded2ce872ce61d2f38f9d03467ebbb8107ef7f33f243d674d6b6b9d948822f9"

  def install
    bin.install "routegroup"
  end

  test do
    system "#{bin}/routegroup"
  end
end
