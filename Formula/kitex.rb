class Kitex < Formula
  desc "Golang RPC framework for microservices"
  homepage "https://example.org/kitex"
  version "0.16.4"
  url "http://127.0.0.1:8080/brew/bottles/kitex--0.16.4.loongarch64.bottle.tar.gz"
  sha256 "314ea074f95dd1472ee439c8105517b466a95e773c6057d240d4d555d348319e"

  def install
    bin.install "kitex"
  end

  test do
    system "#{bin}/kitex"
  end
end
