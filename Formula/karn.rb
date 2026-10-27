class Karn < Formula
  desc "Manage multiple Git identities"
  homepage "https://example.org/karn"
  version "0.1.0"
  url "http://127.0.0.1:8080/brew/bottles/karn--0.1.0.loongarch64.bottle.tar.gz"
  sha256 "f791b95449613f6b927ea62fad4d1af3f4830f19f3b988625f4066afcf97ae2c"

  def install
    bin.install "karn"
  end

  test do
    system "#{bin}/karn"
  end
end
