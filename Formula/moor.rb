class Moor < Formula
  desc "Nice to use pager for humans"
  homepage "https://example.org/moor"
  version "2.19.5"
  url "http://127.0.0.1:8080/brew/bottles/moor--2.19.5.loongarch64.bottle.tar.gz"
  sha256 "38678d4d9d2fc3b651429e989bee9b3731adb4253c260f1711556fef3aa3ab38"

  def install
    bin.install "moor"
  end

  test do
    system "#{bin}/moor"
  end
end
