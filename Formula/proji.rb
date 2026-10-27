class Proji < Formula
  desc "A powerful cross-platform project templating tool."
  homepage "https://example.org/proji"
  version "0.20.0"
  url "http://127.0.0.1:8080/brew/bottles/proji--0.20.0.loongarch64.bottle.tar.gz"
  sha256 "4b079dc6512483c77bebeec2f0b82ffc42187b7a9b06c2b7c115b2f334bb4e6b"

  def install
    bin.install "proji"
  end

  test do
    system "#{bin}/proji"
  end
end
