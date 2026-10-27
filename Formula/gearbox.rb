class Gearbox < Formula
  desc "Gearbox :gear: is a web framework written in Go with a focus on high performance"
  homepage "https://example.org/gearbox"
  version "1.2.4"
  url "http://127.0.0.1:8080/brew/bottles/gearbox--1.2.4.loongarch64.bottle.tar.gz"
  sha256 "9411860bd16a0c1a75dd6eccd1e445fe6460083d0085a5b9b98c3bebd15bd487"

  def install
    bin.install "gearbox"
  end

  test do
    system "#{bin}/gearbox"
  end
end
