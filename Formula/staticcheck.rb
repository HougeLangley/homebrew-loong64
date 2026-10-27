class Staticcheck < Formula
  desc "State of the art linter for the Go programming language"
  homepage "https://example.org/staticcheck"
  version "2026.2.2"
  url "http://127.0.0.1:8080/brew/bottles/staticcheck--2026.2.2.loongarch64.bottle.tar.gz"
  sha256 "54e1c7a962de58301fdaf385a60ca93e2cfcb7ff9294a211d4b6d1f25e0d3ec7"

  def install
    bin.install "staticcheck"
  end

  test do
    system "#{bin}/staticcheck"
  end
end
