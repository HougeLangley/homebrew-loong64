class Tock < Formula
  desc "Tock is a powerful time tracking tool for the command line. It saves activity logs as plai"
  homepage "https://example.org/tock"
  version "2.0.8"
  url "http://127.0.0.1:8080/brew/bottles/tock--2.0.8.loongarch64.bottle.tar.gz"
  sha256 "fca2e17d1d794f874ba07de9841d942f936c80b6522148070f8511afbb40daa9"

  def install
    bin.install "tock"
  end

  test do
    system "#{bin}/tock"
  end
end
