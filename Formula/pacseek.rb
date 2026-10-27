class Pacseek < Formula
  desc "A terminal user interface for searching and installing Arch Linux packages"
  homepage "https://example.org/pacseek"
  version "1.8.7"
  url "http://127.0.0.1:8080/brew/bottles/pacseek--1.8.7.loongarch64.bottle.tar.gz"
  sha256 "301bb76439ee2b5d07c023e2d5ed468509b882e7be74172d37e296bd0d7c8fed"

  def install
    bin.install "pacseek"
  end

  test do
    system "#{bin}/pacseek"
  end
end
