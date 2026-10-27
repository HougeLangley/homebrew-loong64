class Auditbeat < Formula
  desc "Lightweight Shipper for Audit Data"
  homepage "https://example.org/auditbeat"
  version "9.5.5"
  url "http://127.0.0.1:8080/brew/bottles/auditbeat--9.5.5.loongarch64.bottle.tar.gz"
  sha256 "70e935a3cb0c7f80540d0ac3614d64c4b1193821acf41dc3cb6bf143ed885b06"

  def install
    bin.install "auditbeat"
  end

  test do
    system "#{bin}/auditbeat"
  end
end
