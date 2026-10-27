class Handlers < Formula
  desc "Package gorilla/handlers is a collection of useful middleware for Go HTTP services & web a"
  homepage "https://example.org/handlers"
  version "1.5.2"
  url "http://127.0.0.1:8080/brew/bottles/handlers--1.5.2.loongarch64.bottle.tar.gz"
  sha256 "0a83b378ef9eddd9470fa466eb7dd6b5cc006567ea52e727d7a09b30c893868b"

  def install
    bin.install "handlers"
  end

  test do
    system "#{bin}/handlers"
  end
end
