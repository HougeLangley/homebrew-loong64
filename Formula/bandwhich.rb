class Bandwhich < Formula
  desc "Terminal bandwidth utilization tool"
  homepage "https://example.org/bandwhich"
  version "0.23.1"
  url "http://127.0.0.1:8080/brew/bottles/bandwhich--0.23.1.loongarch64.bottle.tar.gz"
  sha256 "9ee90b9a5ff4231956a6f83f6a68a42dd434cdf4af2a0cd4e628db8adea00783"

  def install
    bin.install "bandwhich"
  end

  test do
    system "#{bin}/bandwhich"
  end
end
