class Stuffbin < Formula
  desc "Compress and embed static files and assets into Go binaries"
  homepage "https://example.org/stuffbin"
  version "1.3.0"
  url "http://127.0.0.1:8080/brew/bottles/stuffbin--1.3.0.loongarch64.bottle.tar.gz"
  sha256 "cc0948fe39fbf4b192e3c5d395fd910e78457dff4801e7a78d4d652ac004da80"

  def install
    bin.install "stuffbin"
  end

  test do
    system "#{bin}/stuffbin"
  end
end
