class Ov < Formula
  desc "🎑Feature-rich terminal-based text viewer.  It is a so-called terminal pager."
  homepage "https://example.org/ov"
  version "0.55.0"
  url "http://127.0.0.1:8080/brew/bottles/ov--0.55.0.loongarch64.bottle.tar.gz"
  sha256 "5ff33ea44af37d260f842c2827a34f8f41a41c0ae628f7f2e2eb099f6816d2f0"

  def install
    bin.install "ov"
  end

  test do
    system "#{bin}/ov"
  end
end
