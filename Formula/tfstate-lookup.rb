class Tfstate-lookup < Formula
  desc "Lookup resource attributes in tfstate"
  homepage "https://example.org/tfstate-lookup"
  version "1.12.1"
  url "http://127.0.0.1:8080/brew/bottles/tfstate-lookup--1.12.1.loongarch64.bottle.tar.gz"
  sha256 "cc4b517a207bafdd576f34654d16521fcd92636d03078d53f1f12ba573888536"

  def install
    bin.install "tfstate-lookup"
  end

  test do
    system "#{bin}/tfstate-lookup"
  end
end
