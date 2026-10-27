class Gitsocial < Formula
  desc "Git-native collaboration platform"
  homepage "https://example.org/gitsocial"
  version "0.28.0"
  url "http://127.0.0.1:8080/brew/bottles/gitsocial--0.28.0.loongarch64.bottle.tar.gz"
  sha256 "bba15f1abc51194f7adfbf4f5be7e2d387062fd50126fd339c88e03e57a27db6"

  def install
    bin.install "gitsocial"
  end

  test do
    system "#{bin}/gitsocial"
  end
end
