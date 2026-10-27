class Ls-lint < Formula
  desc "Extremely fast file and directory name linter"
  homepage "https://example.org/ls-lint"
  version "2.3.2"
  url "http://127.0.0.1:8080/brew/bottles/ls-lint--2.3.2.loongarch64.bottle.tar.gz"
  sha256 "3b1197ce59f8d00f0f5fd5db1f9fcd85ba86ec956ec40c9eade03e51e79126d8"

  def install
    bin.install "ls-lint"
  end

  test do
    system "#{bin}/ls-lint"
  end
end
