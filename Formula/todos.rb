class Todos < Formula
  desc "Parse TODO and FIXME comments from code"
  homepage "https://example.org/todos"
  version "0.14.0"
  url "http://127.0.0.1:8080/brew/bottles/todos--0.14.0.loongarch64.bottle.tar.gz"
  sha256 "bd963e6832f6c69ea37a8d63b09b8a47f39fde8ecbab7f8e894c71b5e6f687ef"

  def install
    bin.install "todos"
  end

  test do
    system "#{bin}/todos"
  end
end
