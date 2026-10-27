class Litmusctl < Formula
  desc "Command-line interface for interacting with LitmusChaos"
  homepage "https://example.org/litmusctl"
  version "1.28.0"
  url "http://127.0.0.1:8080/brew/bottles/litmusctl--1.28.0.loongarch64.bottle.tar.gz"
  sha256 "40d46d230637865a7997797090c26bb994900229dbd8f523ee9421b04d115890"

  def install
    bin.install "litmusctl"
  end

  test do
    system "#{bin}/litmusctl"
  end
end
