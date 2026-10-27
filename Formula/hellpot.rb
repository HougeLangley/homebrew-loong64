class Hellpot < Formula
  desc "HellPot is a cross-platform portal to endless suffering meant to punish unruly HTTP bots."
  homepage "https://example.org/hellpot"
  version "0.5.4+build2"
  url "http://127.0.0.1:8080/brew/bottles/hellpot--0.5.4+build2.loongarch64.bottle.tar.gz"
  sha256 "4df719c136fbc3c20e3a7d99b60ad853399abac946af2e5dd9a428acd0b2406e"

  def install
    bin.install "hellpot"
  end

  test do
    system "#{bin}/hellpot"
  end
end
