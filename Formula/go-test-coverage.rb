class Go-test-coverage < Formula
  desc "go-test-coverage is a tool designed to report issues when test coverage falls below a spec"
  homepage "https://example.org/go-test-coverage"
  version "2.20.1"
  url "http://127.0.0.1:8080/brew/bottles/go-test-coverage--2.20.1.loongarch64.bottle.tar.gz"
  sha256 "f4dacd8a9760ecdc1a27ddcc923bf8886ad212f4e13e97f8e99124c726f64f3a"

  def install
    bin.install "go-test-coverage"
  end

  test do
    system "#{bin}/go-test-coverage"
  end
end
