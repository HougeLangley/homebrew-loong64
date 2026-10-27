class Jqfmt < Formula
  desc "Opinionated formatter for jq"
  homepage "https://example.org/jqfmt"
  version "0.1.0"
  url "http://127.0.0.1:8080/brew/bottles/jqfmt--0.1.0.loongarch64.bottle.tar.gz"
  sha256 "5c6b01437c49346c3e4be7aeba769b7e77d5a6f3249dd3404b88e972199c2985"

  def install
    bin.install "jqfmt"
  end

  test do
    system "#{bin}/jqfmt"
  end
end
