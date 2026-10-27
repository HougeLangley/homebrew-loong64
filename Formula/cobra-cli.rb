class Cobra-cli < Formula
  desc "Tool to generate cobra applications and commands"
  homepage "https://example.org/cobra-cli"
  version "1.3.0"
  url "http://127.0.0.1:8080/brew/bottles/cobra-cli--1.3.0.loongarch64.bottle.tar.gz"
  sha256 "6af40bc1b8414c5dcced6c85275ae2cc676ca27f10817697a853ef2191d94eb9"

  def install
    bin.install "cobra-cli"
  end

  test do
    system "#{bin}/cobra-cli"
  end
end
