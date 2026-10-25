class Tokei < Formula
  desc "Count your code, quickly"
  homepage "https://example.org/tokei"
  version "15.0.0"
  url "http://127.0.0.1:8080/brew/bottles/tokei--15.0.0.loongarch64.bottle.tar.gz"
  sha256 "7fed8841f0d21fe263615fd066f41262dfa2dffc463247afd5ecfa23617c4f4a"

  def install
    bin.install "tokei"
  end

  test do
    system "#{bin}/tokei"
  end
end
