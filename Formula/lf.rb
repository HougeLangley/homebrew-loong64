class Lf < Formula
  desc "Terminal file manager"
  homepage "https://example.org/lf"
  version "r42"
  url "http://127.0.0.1:8080/brew/bottles/lf--r42.loongarch64.bottle.tar.gz"
  sha256 "6367ce0e3c42a46fc03caac30fbe732fd586a6855a1c62324c4095173a48d713"

  def install
    bin.install "lf"
  end

  test do
    system "#{bin}/lf"
  end
end
