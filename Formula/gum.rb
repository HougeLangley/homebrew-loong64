class Gum < Formula
  desc "Tool for glamorous shell scripts"
  homepage "https://example.org/gum"
  version "2.0.2"
  url "http://127.0.0.1:8080/brew/bottles/gum--2.0.2.loongarch64.bottle.tar.gz"
  sha256 "5b29112ef86b48a585c4cbab78b2d489d13c5ddebfd2208ef284b9d6f0eeaf0b"

  def install
    bin.install "gum"
  end

  test do
    system "#{bin}/gum"
  end
end
