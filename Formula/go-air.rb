class Go-air < Formula
  desc "Live reload for Go apps"
  homepage "https://example.org/go-air"
  version "1.67.4"
  url "http://127.0.0.1:8080/brew/bottles/go-air--1.67.4.loongarch64.bottle.tar.gz"
  sha256 "e230f45981e3641496f8b8713b8670a3cd351caa4df817817dbfa434d0658dad"

  def install
    bin.install "go-air"
  end

  test do
    system "#{bin}/go-air"
  end
end
