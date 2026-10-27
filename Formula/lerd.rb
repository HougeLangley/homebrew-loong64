class Lerd < Formula
  desc "Open-source local PHP development environment for Linux, macOS and Windows (WSL2). Automat"
  homepage "https://example.org/lerd"
  version "1.37.1"
  url "http://127.0.0.1:8080/brew/bottles/lerd--1.37.1.loongarch64.bottle.tar.gz"
  sha256 "62922b1bceb77863e4bd9f03f8061722e469c4d7f111b5c7d6d4cbba7347e980"

  def install
    bin.install "lerd"
  end

  test do
    system "#{bin}/lerd"
  end
end
