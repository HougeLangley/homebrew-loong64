class Gophish < Formula
  desc "Open-Source Phishing Toolkit"
  homepage "https://example.org/gophish"
  version "0.12.1"
  url "http://127.0.0.1:8080/brew/bottles/gophish--0.12.1.loongarch64.bottle.tar.gz"
  sha256 "389618d4e2dc7259720da74a34ccafd2a46e9b636b9570ca4202d007d0494659"

  def install
    bin.install "gophish"
  end

  test do
    system "#{bin}/gophish"
  end
end
