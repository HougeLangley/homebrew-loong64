class Go-httpbin < Formula
  desc "A reasonably complete and well-tested golang port of httpbin, with zero dependencies outsi"
  homepage "https://example.org/go-httpbin"
  version "2.26.0"
  url "http://127.0.0.1:8080/brew/bottles/go-httpbin--2.26.0.loongarch64.bottle.tar.gz"
  sha256 "6eadcaee9e1184b25d2b6d825bd92d14e416d2a3465ccf1b6968ef85e197a7cf"

  def install
    bin.install "go-httpbin"
  end

  test do
    system "#{bin}/go-httpbin"
  end
end
