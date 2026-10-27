class Encore < Formula
  desc "Infrastructure orchestration from local to your cloud"
  homepage "https://example.org/encore"
  version "1.58.8"
  url "http://127.0.0.1:8080/brew/bottles/encore--1.58.8.loongarch64.bottle.tar.gz"
  sha256 "12c7aad8593c016c861e748292292ec083a772c11f69d479f0e9d65df85bb945"

  def install
    bin.install "encore"
  end

  test do
    system "#{bin}/encore"
  end
end
