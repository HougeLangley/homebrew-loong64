class Sponge < Formula
  desc "A powerful and easy-to-use Go development framework that enables you to effortlessly build"
  homepage "https://example.org/sponge"
  version "1.16.1"
  url "http://127.0.0.1:8080/brew/bottles/sponge--1.16.1.loongarch64.bottle.tar.gz"
  sha256 "7b3c4a923b8fc3c0ace3b6296bdf5239c875002ff3af3b3c7751e532f5a93a14"

  def install
    bin.install "sponge"
  end

  test do
    system "#{bin}/sponge"
  end
end
