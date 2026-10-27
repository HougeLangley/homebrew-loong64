class Scrutineer < Formula
  desc "Security through scrutiny"
  homepage "https://example.org/scrutineer"
  version "2026.10.24.1"
  url "http://127.0.0.1:8080/brew/bottles/scrutineer--2026.10.24.1.loongarch64.bottle.tar.gz"
  sha256 "a61b6bb6b9f56625ebe98b8a3e2625602bbfc4e6e45d0b8ce925e1d9d05cd0ea"

  def install
    bin.install "scrutineer"
  end

  test do
    system "#{bin}/scrutineer"
  end
end
