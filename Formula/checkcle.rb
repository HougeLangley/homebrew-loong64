class Checkcle < Formula
  desc "CheckCle is a self-hosted, open-source monitoring platform for seamless, real-time full-st"
  homepage "https://example.org/checkcle"
  version "1.6.0"
  url "http://127.0.0.1:8080/brew/bottles/checkcle--1.6.0.loongarch64.bottle.tar.gz"
  sha256 "2b77b9b75caa90126dd357daba6e23e439dcafda30d95be9c6ab32e8ba7c824a"

  def install
    bin.install "checkcle"
  end

  test do
    system "#{bin}/checkcle"
  end
end
