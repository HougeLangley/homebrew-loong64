class Advancecomp < Formula
  desc "Recompression utilities for .PNG, .MNG, .ZIP, and .GZ files"
  homepage "https://example.org/advancecomp"
  version "2.6"
  url "http://127.0.0.1:8080/brew/bottles/advancecomp--2.6.loongarch64.bottle.tar.gz"
  sha256 "4163dd783a823c9514e159328f804ee299b6222def502666bfe398c139469f48"

  def install
    bin.install "advancecomp"
  end

  test do
    system "#{bin}/advancecomp"
  end
end
