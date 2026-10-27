class Pscale < Formula
  desc "CLI for PlanetScale Database"
  homepage "https://example.org/pscale"
  version "0.348.0"
  url "http://127.0.0.1:8080/brew/bottles/pscale--0.348.0.loongarch64.bottle.tar.gz"
  sha256 "0b4483ac4a371ee263ee334c09a7724c901def274a44c3cf27307b07aa8c76d9"

  def install
    bin.install "pscale"
  end

  test do
    system "#{bin}/pscale"
  end
end
