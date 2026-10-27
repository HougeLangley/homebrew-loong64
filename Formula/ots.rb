class Ots < Formula
  desc "🔐 Share end-to-end encrypted secrets with others via a one-time URL"
  homepage "https://example.org/ots"
  version "0.3.1"
  url "http://127.0.0.1:8080/brew/bottles/ots--0.3.1.loongarch64.bottle.tar.gz"
  sha256 "c76352e2108f8c4b3310be695e7f71c3b47db547e0f3287d2143a8ec1c46b72a"

  def install
    bin.install "ots"
  end

  test do
    system "#{bin}/ots"
  end
end
