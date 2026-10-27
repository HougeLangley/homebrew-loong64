class Manifest-tool < Formula
  desc "Command-line tool to create and query container image manifest list/indexes"
  homepage "https://example.org/manifest-tool"
  version "2.2.2"
  url "http://127.0.0.1:8080/brew/bottles/manifest-tool--2.2.2.loongarch64.bottle.tar.gz"
  sha256 "94a8df3b0e90dd3a0d20b9d50056b9cc7aae53fbb15c584710a2e146bd34ff2d"

  def install
    bin.install "manifest-tool"
  end

  test do
    system "#{bin}/manifest-tool"
  end
end
