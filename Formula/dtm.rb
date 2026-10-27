class Dtm < Formula
  desc "Cross-language distributed transaction manager"
  homepage "https://example.org/dtm"
  version "1.19.0"
  url "http://127.0.0.1:8080/brew/bottles/dtm--1.19.0.loongarch64.bottle.tar.gz"
  sha256 "2aa33b05cb22c5ba9534a7ea2cc737082b80aea1a2c7cb4cfbf29b4f927b28f8"

  def install
    bin.install "dtm"
  end

  test do
    system "#{bin}/dtm"
  end
end
