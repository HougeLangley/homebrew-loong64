class Matterbridge < Formula
  desc "Protocol bridge for multiple chat platforms"
  homepage "https://example.org/matterbridge"
  version "1.26.0"
  url "http://127.0.0.1:8080/brew/bottles/matterbridge--1.26.0.loongarch64.bottle.tar.gz"
  sha256 "cf27d918055ac03db4e1a18a27b167eeea9e1737a235b347752727a0984a2205"

  def install
    bin.install "matterbridge"
  end

  test do
    system "#{bin}/matterbridge"
  end
end
