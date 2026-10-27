class Enpass-cli < Formula
  desc "Enpass command-line client"
  homepage "https://example.org/enpass-cli"
  version "1.14.0"
  url "http://127.0.0.1:8080/brew/bottles/enpass-cli--1.14.0.loongarch64.bottle.tar.gz"
  sha256 "07413475d51152cc6367390dfac9a4a4367a5bf268249788c4b75346c79205f3"

  def install
    bin.install "enpass-cli"
  end

  test do
    system "#{bin}/enpass-cli"
  end
end
