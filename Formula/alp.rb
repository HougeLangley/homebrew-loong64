class Alp < Formula
  desc "Access Log Profiler"
  homepage "https://example.org/alp"
  version "1.0.22"
  url "http://127.0.0.1:8080/brew/bottles/alp--1.0.22.loongarch64.bottle.tar.gz"
  sha256 "d7ec584605f73272c72626baa35c49f9bb7bf39a702cdf5f6e5b01e1bea0dcc2"

  def install
    bin.install "alp"
  end

  test do
    system "#{bin}/alp"
  end
end
