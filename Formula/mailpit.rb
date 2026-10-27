class Mailpit < Formula
  desc "Web and API based SMTP testing"
  homepage "https://example.org/mailpit"
  version "1.32.0"
  url "http://127.0.0.1:8080/brew/bottles/mailpit--1.32.0.loongarch64.bottle.tar.gz"
  sha256 "fbd090a4ea6a9d16533b84ef0f7b2e66c5adf24ccafba28ace367e2be310c828"

  def install
    bin.install "mailpit"
  end

  test do
    system "#{bin}/mailpit"
  end
end
