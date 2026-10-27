class Logdy < Formula
  desc "Web based real-time log viewer"
  homepage "https://example.org/logdy"
  version "0.17.1"
  url "http://127.0.0.1:8080/brew/bottles/logdy--0.17.1.loongarch64.bottle.tar.gz"
  sha256 "2897dea39bb1653cba7062586a96d18eaaa524a06d577b40565b71cd199e4659"

  def install
    bin.install "logdy"
  end

  test do
    system "#{bin}/logdy"
  end
end
