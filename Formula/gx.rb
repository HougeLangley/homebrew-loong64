class Gx < Formula
  desc "Language-agnostic, universal package manager"
  homepage "https://example.org/gx"
  version "0.14.3"
  url "http://127.0.0.1:8080/brew/bottles/gx--0.14.3.loongarch64.bottle.tar.gz"
  sha256 "83ba380d21a506d6df4fa5eb74ab7e09a0f9b57b984a995b4b7baec99f266357"

  def install
    bin.install "gx"
  end

  test do
    system "#{bin}/gx"
  end
end
