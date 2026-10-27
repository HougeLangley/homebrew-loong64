class Codeaf < Formula
  desc "Open-Source Software factory for Open Models"
  homepage "https://example.org/codeaf"
  version "0.8.2"
  url "http://127.0.0.1:8080/brew/bottles/codeaf--0.8.2.loongarch64.bottle.tar.gz"
  sha256 "634debefd696edcea1685ab8eeee73371470637081cf459f0b41ff6c1094bb8d"

  def install
    bin.install "codeaf"
  end

  test do
    system "#{bin}/codeaf"
  end
end
