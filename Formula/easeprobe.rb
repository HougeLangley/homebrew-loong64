class Easeprobe < Formula
  desc "Simple, standalone, and lightWeight tool that can do health/status checking"
  homepage "https://example.org/easeprobe"
  version "2.3.0"
  url "http://127.0.0.1:8080/brew/bottles/easeprobe--2.3.0.loongarch64.bottle.tar.gz"
  sha256 "74548dd6b351cfee00e715309b2dcfc1996666ae3d61bf659ce504b64a1b5dc1"

  def install
    bin.install "easeprobe"
  end

  test do
    system "#{bin}/easeprobe"
  end
end
