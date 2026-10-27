class Chyle < Formula
  desc "Changelog generator : use a git repository and various data sources and publish the result"
  homepage "https://example.org/chyle"
  version "1.20.0"
  url "http://127.0.0.1:8080/brew/bottles/chyle--1.20.0.loongarch64.bottle.tar.gz"
  sha256 "75f15338b46eff6bb5084bc46a4ecf43a553001f19530973288da90edf176a0b"

  def install
    bin.install "chyle"
  end

  test do
    system "#{bin}/chyle"
  end
end
