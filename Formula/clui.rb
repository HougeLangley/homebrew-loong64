class Clui < Formula
  desc "Command Line User Interface (Console UI inspired by TurboVision)"
  homepage "https://example.org/clui"
  version ".1.2.1"
  url "http://127.0.0.1:8080/brew/bottles/clui--.1.2.1.loongarch64.bottle.tar.gz"
  sha256 "80dcee4461b09563e9999ded95dbbdba5b04c9454353ba743134f8f64e8e3856"

  def install
    bin.install "clui"
  end

  test do
    system "#{bin}/clui"
  end
end
