class Tz < Formula
  desc "CLI time zone visualizer"
  homepage "https://example.org/tz"
  version "0.8.0"
  url "http://127.0.0.1:8080/brew/bottles/tz--0.8.0.loongarch64.bottle.tar.gz"
  sha256 "91223621919712b282caaf797c6c64c98ec7b7726d4bc70698f51e3ebdbaacce"

  def install
    bin.install "tz"
  end

  test do
    system "#{bin}/tz"
  end
end
