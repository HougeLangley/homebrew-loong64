class Vhs < Formula
  desc "Your CLI home video recorder 📼"
  homepage "https://example.org/vhs"
  version "0.12.1"
  url "http://127.0.0.1:8080/brew/bottles/vhs--0.12.1.loongarch64.bottle.tar.gz"
  sha256 "15f646b79c686533d41345d74fae95f867e239b01a8103eb5adb3ab0d6ff7a0b"

  def install
    bin.install "vhs"
  end

  test do
    system "#{bin}/vhs"
  end
end
