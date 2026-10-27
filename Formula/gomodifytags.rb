class Gomodifytags < Formula
  desc "Go tool to modify struct field tags"
  homepage "https://example.org/gomodifytags"
  version "1.17.0"
  url "http://127.0.0.1:8080/brew/bottles/gomodifytags--1.17.0.loongarch64.bottle.tar.gz"
  sha256 "6a799cc88620aa632abfa10ba32a037de986438c1665499a07f5af1985ddf956"

  def install
    bin.install "gomodifytags"
  end

  test do
    system "#{bin}/gomodifytags"
  end
end
