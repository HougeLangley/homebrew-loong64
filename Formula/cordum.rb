class Cordum < Formula
  desc "The action firewall for AI agents. Enforce policy and human approval before risky tool cal"
  homepage "https://example.org/cordum"
  version "1.2.0"
  url "http://127.0.0.1:8080/brew/bottles/cordum--1.2.0.loongarch64.bottle.tar.gz"
  sha256 "26307b230d83c325fb23bb73e4860af9a42caa3b13a2caffea9346de2c24c45e"

  def install
    bin.install "cordum"
  end

  test do
    system "#{bin}/cordum"
  end
end
