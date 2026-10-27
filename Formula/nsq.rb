class Nsq < Formula
  desc "Realtime distributed messaging platform"
  homepage "https://example.org/nsq"
  version "1.3.0"
  url "http://127.0.0.1:8080/brew/bottles/nsq--1.3.0.loongarch64.bottle.tar.gz"
  sha256 "08b5c7f2b3956d3fc5317492d47c57b631f922e25a51e66e9f6b734b75e50569"

  def install
    bin.install "nsq"
  end

  test do
    system "#{bin}/nsq"
  end
end
