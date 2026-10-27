class Qrkey < Formula
  desc "Generate and recover QR codes from files for offline private key backup"
  homepage "https://example.org/qrkey"
  version "0.0.1"
  url "http://127.0.0.1:8080/brew/bottles/qrkey--0.0.1.loongarch64.bottle.tar.gz"
  sha256 "67789cbdb35681c734eed2f716a186523f2aa1381a36b0fbc168de5044c36b30"

  def install
    bin.install "qrkey"
  end

  test do
    system "#{bin}/qrkey"
  end
end
