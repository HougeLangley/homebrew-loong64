class Nebula < Formula
  desc "Scalable overlay networking tool for connecting computers anywhere"
  homepage "https://example.org/nebula"
  version "1.11.2"
  url "http://127.0.0.1:8080/brew/bottles/nebula--1.11.2.loongarch64.bottle.tar.gz"
  sha256 "2fc024776b8a4a99feec192d7fbf4992d2c164edb38105b30420f73b1b613746"

  def install
    bin.install "nebula"
  end

  test do
    system "#{bin}/nebula"
  end
end
