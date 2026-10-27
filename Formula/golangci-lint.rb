class Golangci-lint < Formula
  desc "Fast linters runner for Go"
  homepage "https://example.org/golangci-lint"
  version "2.15.0"
  url "http://127.0.0.1:8080/brew/bottles/golangci-lint--2.15.0.loongarch64.bottle.tar.gz"
  sha256 "6920bb6ef2e83c60cd42f0f000e667543ed0b1e706615a605759624a919882eb"

  def install
    bin.install "golangci-lint"
  end

  test do
    system "#{bin}/golangci-lint"
  end
end
