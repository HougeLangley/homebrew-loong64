class Hello < Formula
  desc "A hello world demo program"
  homepage "https://example.org/hello"
  version "1.0.0"
  url "http://127.0.0.1:8080/brew/bottles/hello--1.0.0.loongarch64.bottle.tar.gz"
  sha256 "e27343330553064de9fd067144f96bbbd1a9a1d52d87deb97ad5a2220b493905"

  def install
    bin.install "hello"
  end

  test do
    assert_match "Hello", shell_output("#{bin}/hello")
  end
end
