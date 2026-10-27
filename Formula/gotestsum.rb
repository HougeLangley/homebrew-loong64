class Gotestsum < Formula
  desc "Human friendly  runner"
  homepage "https://example.org/gotestsum"
  version "1.13.0"
  url "http://127.0.0.1:8080/brew/bottles/gotestsum--1.13.0.loongarch64.bottle.tar.gz"
  sha256 "92421a0a0262eec82395bb34d4957e39f54baae30e718240e3e2eb0f14b4f008"

  def install
    bin.install "gotestsum"
  end

  test do
    system "#{bin}/gotestsum"
  end
end
