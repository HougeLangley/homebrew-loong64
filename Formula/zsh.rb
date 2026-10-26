class Zsh < Formula
  desc "The Z shell"
  homepage "https://example.org/zsh"
  version "5.9.2"
  url "http://127.0.0.1:8080/brew/bottles/zsh--5.9.2.loongarch64.bottle.tar.gz"
  sha256 "dcac68cdf89e20716c1978e4742c1b03031dbefa621e4d1e47f6c5644506074a"

  def install
    bin.install "zsh"
  end

  test do
    system "#{bin}/zsh"
  end
end
