class Go-arch-lint < Formula
  desc "Architecture linter for Go projects"
  homepage "https://example.org/go-arch-lint"
  version "1.19.0"
  url "http://127.0.0.1:8080/brew/bottles/go-arch-lint--1.19.0.loongarch64.bottle.tar.gz"
  sha256 "33ff73896029424f4634fe6341da5b5336e7bc227a788e4fe637ed70610b986c"

  def install
    bin.install "go-arch-lint"
  end

  test do
    system "#{bin}/go-arch-lint"
  end
end
