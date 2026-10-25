class Less < Formula
  desc "Pager program similar to more"
  homepage "https://example.org/less"
  version "710"
  url "http://127.0.0.1:8080/brew/bottles/less--710.loongarch64.bottle.tar.gz"
  sha256 "67924aa8a46972a0615695445451cc09fb6d54bb4a2361ad209b854d83598f77"

  def install
    bin.install "less"
  end

  test do
    system "#{bin}/less"
  end
end
