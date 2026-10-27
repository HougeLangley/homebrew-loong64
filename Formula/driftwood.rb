class Driftwood < Formula
  desc "Private key usage verification"
  homepage "https://example.org/driftwood"
  version "1.0.1"
  url "http://127.0.0.1:8080/brew/bottles/driftwood--1.0.1.loongarch64.bottle.tar.gz"
  sha256 "914f4d453c19566d9959536edb9420b7e1fa72629b55f43e59eb35f224e52e6c"

  def install
    bin.install "driftwood"
  end

  test do
    system "#{bin}/driftwood"
  end
end
