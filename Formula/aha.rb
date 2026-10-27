class Aha < Formula
  desc "ANSI HTML adapter"
  homepage "https://example.org/aha"
  version "0.5.1"
  url "http://127.0.0.1:8080/brew/bottles/aha--0.5.1.loongarch64.bottle.tar.gz"
  sha256 "972369f574ed07c7ce99e4925e4cb1bde462e201f26e189f1e9eb817aa358043"

  def install
    bin.install "aha"
  end

  test do
    system "#{bin}/aha"
  end
end
