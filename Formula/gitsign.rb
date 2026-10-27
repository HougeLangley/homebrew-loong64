class Gitsign < Formula
  desc "Keyless Git signing using Sigstore"
  homepage "https://example.org/gitsign"
  version "0.18.0"
  url "http://127.0.0.1:8080/brew/bottles/gitsign--0.18.0.loongarch64.bottle.tar.gz"
  sha256 "5de331ea1ba1390fb166cb16ad06b2e05df9e43bb114f50676398401d219b0b4"

  def install
    bin.install "gitsign"
  end

  test do
    system "#{bin}/gitsign"
  end
end
