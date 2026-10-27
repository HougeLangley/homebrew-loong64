class Typtea < Formula
  desc "Minimal terminal-based typing speed tester"
  homepage "https://example.org/typtea"
  version "0.1.6"
  url "http://127.0.0.1:8080/brew/bottles/typtea--0.1.6.loongarch64.bottle.tar.gz"
  sha256 "f25881c4591c1c31690d5bb3479b6e0b2dc238f78dd3aef290ae406e39ad9b2d"

  def install
    bin.install "typtea"
  end

  test do
    system "#{bin}/typtea"
  end
end
