class Jq < Formula
  desc "Command-line JSON processor"
  homepage "https://example.org/jq"
  version "1.8.2"
  url "http://127.0.0.1:8080/brew/bottles/jq--1.8.2.loongarch64.bottle.tar.gz"
  sha256 "4a8710c3d9e9a2e05e99c4388821ac92772f321922731b3b1ba6cf1802b923c5"

  def install
    bin.install "jq"
  end

  test do
    system "#{bin}/jq"
  end
end
