class Termshot < Formula
  desc "Creates screenshots based on terminal command output"
  homepage "https://example.org/termshot"
  version "0.6.1"
  url "http://127.0.0.1:8080/brew/bottles/termshot--0.6.1.loongarch64.bottle.tar.gz"
  sha256 "f5524280ab5fa816eaac159871ea7023c5c23a2893de78da608c55cadd10d08b"

  def install
    bin.install "termshot"
  end

  test do
    system "#{bin}/termshot"
  end
end
