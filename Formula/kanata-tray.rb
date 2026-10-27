class Kanata-tray < Formula
  desc "System tray for kanata keyboard remapper"
  homepage "https://example.org/kanata-tray"
  version "0.8.0"
  url "http://127.0.0.1:8080/brew/bottles/kanata-tray--0.8.0.loongarch64.bottle.tar.gz"
  sha256 "889c1efa89a6bce79d6230d3fef29339ef14474e3720171a4b625183dc9dad98"

  def install
    bin.install "kanata-tray"
  end

  test do
    system "#{bin}/kanata-tray"
  end
end
