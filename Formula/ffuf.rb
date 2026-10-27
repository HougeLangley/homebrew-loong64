class Ffuf < Formula
  desc "Fast web fuzzer written in Go"
  homepage "https://example.org/ffuf"
  version "2.3.0"
  url "http://127.0.0.1:8080/brew/bottles/ffuf--2.3.0.loongarch64.bottle.tar.gz"
  sha256 "781d16378600f8bf74b3a8155c67dd79300b1455ae7c88e7aaf881b6523e2b23"

  def install
    bin.install "ffuf"
  end

  test do
    system "#{bin}/ffuf"
  end
end
