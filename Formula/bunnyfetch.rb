class Bunnyfetch < Formula
  desc "🐰 Tiny system info fetch utility."
  homepage "https://example.org/bunnyfetch"
  version "0.2.0"
  url "http://127.0.0.1:8080/brew/bottles/bunnyfetch--0.2.0.loongarch64.bottle.tar.gz"
  sha256 "ae7072cbef5f57f9faefb1f095d8580d7cfe49c062ac974912491fd9e315a1c6"

  def install
    bin.install "bunnyfetch"
  end

  test do
    system "#{bin}/bunnyfetch"
  end
end
