class Llgo < Formula
  desc "Go compiler based on LLVM integrate with the C ecosystem and Python"
  homepage "https://example.org/llgo"
  version "1.0.8"
  url "http://127.0.0.1:8080/brew/bottles/llgo--1.0.8.loongarch64.bottle.tar.gz"
  sha256 "1dbb84d212b8b507bbe46d5b3ad0b2cb73a5bdac5c17c9e9999ef3e8fd3d4090"

  def install
    bin.install "llgo"
  end

  test do
    system "#{bin}/llgo"
  end
end
