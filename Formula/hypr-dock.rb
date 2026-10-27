class Hypr-dock < Formula
  desc "Interactive Dock Panel for Hyprland"
  homepage "https://example.org/hypr-dock"
  version "1.2.1"
  url "http://127.0.0.1:8080/brew/bottles/hypr-dock--1.2.1.loongarch64.bottle.tar.gz"
  sha256 "0986dd532c594e6edd4bef6719fd469cd9d8fe39ae36ca90e48ec7f0958bcb51"

  def install
    bin.install "hypr-dock"
  end

  test do
    system "#{bin}/hypr-dock"
  end
end
