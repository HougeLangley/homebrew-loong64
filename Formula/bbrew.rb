class Bbrew < Formula
  desc "TUI for managing Homebrew, Flatpak, and Mac App Store packages"
  homepage "https://example.org/bbrew"
  version "2.3.2"
  url "http://127.0.0.1:8080/brew/bottles/bbrew--2.3.2.loongarch64.bottle.tar.gz"
  sha256 "4fa4097be32d065e0607f9349761fc1b3960a7e86571d29b426663b14261c67c"

  def install
    bin.install "bbrew"
  end

  test do
    system "#{bin}/bbrew"
  end
end
