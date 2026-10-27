class Infisical < Formula
  desc "CLI for Infisical"
  homepage "https://example.org/infisical"
  version "0.44.9"
  url "http://127.0.0.1:8080/brew/bottles/infisical--0.44.9.loongarch64.bottle.tar.gz"
  sha256 "91bf139b1ba3668c39732236d3e90369685505cfedf87b3ea101f69543c09e5e"

  def install
    bin.install "infisical"
  end

  test do
    system "#{bin}/infisical"
  end
end
