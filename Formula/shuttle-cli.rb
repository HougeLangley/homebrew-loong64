class Shuttle-cli < Formula
  desc "CLI for handling shared build and deploy tools between many projects"
  homepage "https://example.org/shuttle-cli"
  version "0.25.2"
  url "http://127.0.0.1:8080/brew/bottles/shuttle-cli--0.25.2.loongarch64.bottle.tar.gz"
  sha256 "efcf18bb4f985b8409f85dc492337d672f60a93fd0a540d5c793e50fa736c521"

  def install
    bin.install "shuttle-cli"
  end

  test do
    system "#{bin}/shuttle-cli"
  end
end
