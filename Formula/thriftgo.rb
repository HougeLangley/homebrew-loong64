class Thriftgo < Formula
  desc "Implementation of thrift compiler in go language with plugin mechanism"
  homepage "https://example.org/thriftgo"
  version "0.4.5"
  url "http://127.0.0.1:8080/brew/bottles/thriftgo--0.4.5.loongarch64.bottle.tar.gz"
  sha256 "c3701cfdf1f5a4fbc1adcc7ab7f55d21427729155a251ba981abaf023a177b68"

  def install
    bin.install "thriftgo"
  end

  test do
    system "#{bin}/thriftgo"
  end
end
