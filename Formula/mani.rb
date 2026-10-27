class Mani < Formula
  desc ":robot: CLI tool to help you manage repositories"
  homepage "https://example.org/mani"
  version "0.32.1"
  url "http://127.0.0.1:8080/brew/bottles/mani--0.32.1.loongarch64.bottle.tar.gz"
  sha256 "f03f5351a544438352fe6c0880eb88fef23253a47d72aa53ddb94aeb2c911960"

  def install
    bin.install "mani"
  end

  test do
    system "#{bin}/mani"
  end
end
