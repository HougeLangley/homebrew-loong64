class Versioninfo < Formula
  desc "Importable package that parses version info from debug.ReadBuildInfo()."
  homepage "https://example.org/versioninfo"
  version "2.24.1"
  url "http://127.0.0.1:8080/brew/bottles/versioninfo--2.24.1.loongarch64.bottle.tar.gz"
  sha256 "10e5b51f5db7e0cf123c712ebb203c899c9534cf50732e89e95a60f44d25f5a5"

  def install
    bin.install "versioninfo"
  end

  test do
    system "#{bin}/versioninfo"
  end
end
