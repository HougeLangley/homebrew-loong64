class Pyroscope < Formula
  desc "Continuous Profiling Platform. Debug performance issues down to a single line of code"
  homepage "https://example.org/pyroscope"
  version "2.4.2"
  url "http://127.0.0.1:8080/brew/bottles/pyroscope--2.4.2.loongarch64.bottle.tar.gz"
  sha256 "3c2eb419efc1027add0475811386c58f8be1152af6b0a1923deccdd0cba47163"

  def install
    bin.install "pyroscope"
  end

  test do
    system "#{bin}/pyroscope"
  end
end
