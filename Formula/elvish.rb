class Elvish < Formula
  desc "Friendly and expressive shell"
  homepage "https://example.org/elvish"
  version "0.21.0"
  url "http://127.0.0.1:8080/brew/bottles/elvish--0.21.0.loongarch64.bottle.tar.gz"
  sha256 "f954b08f27343f02ce127a1fe2e30886cc78698034f495ed0b9d3ab90ea0fb3a"

  def install
    bin.install "elvish"
  end

  test do
    system "#{bin}/elvish"
  end
end
