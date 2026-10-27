class Immich-go < Formula
  desc "Alternative to the official immich-CLI command written in Go"
  homepage "https://example.org/immich-go"
  version "0.32.0"
  url "http://127.0.0.1:8080/brew/bottles/immich-go--0.32.0.loongarch64.bottle.tar.gz"
  sha256 "77fd9f085d3aaa017923713fcae7103302e59d24fe1c63a0e910e6a10c7ea491"

  def install
    bin.install "immich-go"
  end

  test do
    system "#{bin}/immich-go"
  end
end
