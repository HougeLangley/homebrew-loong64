class Exercism < Formula
  desc "Command-line tool to interact with exercism.io"
  homepage "https://example.org/exercism"
  version "3.5.9"
  url "http://127.0.0.1:8080/brew/bottles/exercism--3.5.9.loongarch64.bottle.tar.gz"
  sha256 "59843f6b1e36f56889bf69415ca08cf0e5c3d332bae2503d2c0ab996e5c7d7b0"

  def install
    bin.install "exercism"
  end

  test do
    system "#{bin}/exercism"
  end
end
