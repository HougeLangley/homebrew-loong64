class Ruff < Formula
  desc "Fast Python linter"
  homepage "https://example.org/ruff"
  version "0.17.2"
  url "http://127.0.0.1:8080/brew/bottles/ruff--0.17.2.loongarch64.bottle.tar.gz"
  sha256 "9d521bdacaba138cb419a8db50ba3007343882842c1ae546215d9b9d0fdba369"

  def install
    bin.install "ruff"
  end

  test do
    system "#{bin}/ruff"
  end
end
