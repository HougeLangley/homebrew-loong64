class Bomber < Formula
  desc "Scans Software Bill of Materials for security vulnerabilities"
  homepage "https://example.org/bomber"
  version "0.5.1"
  url "http://127.0.0.1:8080/brew/bottles/bomber--0.5.1.loongarch64.bottle.tar.gz"
  sha256 "b0cd252e9ed939ba14a51fca78aeb764e608ff2fab8fa55520a8f9cfa42c328e"

  def install
    bin.install "bomber"
  end

  test do
    system "#{bin}/bomber"
  end
end
