class Golangci-lint-langserver < Formula
  desc "Language server for "
  homepage "https://example.org/golangci-lint-langserver"
  version "0.0.12"
  url "http://127.0.0.1:8080/brew/bottles/golangci-lint-langserver--0.0.12.loongarch64.bottle.tar.gz"
  sha256 "0b989e3385d20e64cb228b853f6fc73bc91e36ee416fd9a285b834261d851063"

  def install
    bin.install "golangci-lint-langserver"
  end

  test do
    system "#{bin}/golangci-lint-langserver"
  end
end
