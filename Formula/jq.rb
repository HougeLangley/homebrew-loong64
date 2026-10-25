class Jq < Formula
  desc "Command-line JSON processor"
  homepage "https://example.org/jq"
  version "1.8.2"
  url "http://127.0.0.1:8080/brew/bottles/jq--1.8.2.loongarch64.bottle.tar.gz"
  sha256 "acb6139ce84a50ba65582848953ce5c779d559ba9d3d5e0601a8ef686dadecf4"

  def install
    bin.install "jq"
  end

  test do
    system "#{bin}/jq"
  end
end
