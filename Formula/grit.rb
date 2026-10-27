class Grit < Formula
  desc "Multitree-based personal task manager"
  homepage "https://example.org/grit"
  version "0.3.0"
  url "http://127.0.0.1:8080/brew/bottles/grit--0.3.0.loongarch64.bottle.tar.gz"
  sha256 "f15cbab50042d4df055db30d4848cab6564a8d007ec92506c531434b6f0ed926"

  def install
    bin.install "grit"
  end

  test do
    system "#{bin}/grit"
  end
end
