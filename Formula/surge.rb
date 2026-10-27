class Surge < Formula
  desc "Blazing fast TUI download manager built in Go for power users"
  homepage "https://example.org/surge"
  version "0.12.3"
  url "http://127.0.0.1:8080/brew/bottles/surge--0.12.3.loongarch64.bottle.tar.gz"
  sha256 "bd7fc073503920dbd24b5017e1ea22814b1cc6be37b3b4c9d57fd8152f3b954d"

  def install
    bin.install "surge"
  end

  test do
    system "#{bin}/surge"
  end
end
