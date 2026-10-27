class Actionlint < Formula
  desc "Static checker for GitHub Actions workflow files"
  homepage "https://example.org/actionlint"
  version "1.7.12"
  url "http://127.0.0.1:8080/brew/bottles/actionlint--1.7.12.loongarch64.bottle.tar.gz"
  sha256 "7616c8912b414c13da08c9ee37a847679eb1b85752e03bb35003521f769c6dd7"

  def install
    bin.install "actionlint"
  end

  test do
    system "#{bin}/actionlint"
  end
end
