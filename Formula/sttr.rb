class Sttr < Formula
  desc "cross-platform, cli app to perform various operations on string"
  homepage "https://example.org/sttr"
  version "0.2.30"
  url "http://127.0.0.1:8080/brew/bottles/sttr--0.2.30.loongarch64.bottle.tar.gz"
  sha256 "7d5ecfba22952566f823e6421160469a442d67eb4f0f65b5fc0ae2075ff94949"

  def install
    bin.install "sttr"
  end

  test do
    system "#{bin}/sttr"
  end
end
