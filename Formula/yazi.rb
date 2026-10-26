class Yazi < Formula
  desc "Terminal file manager"
  homepage "https://example.org/yazi"
  version "26.9.1"
  url "http://127.0.0.1:8080/brew/bottles/yazi--26.9.1.loongarch64.bottle.tar.gz"
  sha256 "02d11d49c5dc754c03a77a55a9ea468a8cc410d3ae90fd0b456655b9bc4cb70e"

  def install
    bin.install "yazi"
  end

  test do
    system "#{bin}/yazi"
  end
end
