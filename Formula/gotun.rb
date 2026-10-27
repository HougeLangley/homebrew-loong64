class Gotun < Formula
  desc "Lightweight HTTP proxy over SSH"
  homepage "https://example.org/gotun"
  version "0.8.1"
  url "http://127.0.0.1:8080/brew/bottles/gotun--0.8.1.loongarch64.bottle.tar.gz"
  sha256 "0343584e89459c0c945ea2e147e4e27a6212d984ee7c167f6e615a7ab839ccf9"

  def install
    bin.install "gotun"
  end

  test do
    system "#{bin}/gotun"
  end
end
