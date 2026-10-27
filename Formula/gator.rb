class Gator < Formula
  desc "CLI Utility for Open Policy Agent Gatekeeper"
  homepage "https://example.org/gator"
  version "3.23.1"
  url "http://127.0.0.1:8080/brew/bottles/gator--3.23.1.loongarch64.bottle.tar.gz"
  sha256 "387ad100a3c451669d401fa9350d56f618aa809dfe59b16372422ed0c27929f5"

  def install
    bin.install "gator"
  end

  test do
    system "#{bin}/gator"
  end
end
