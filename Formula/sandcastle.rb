class Sandcastle < Formula
  desc "A high-performance, lightweight build tool."
  homepage "https://example.org/sandcastle"
  version "0.3.0"
  url "http://127.0.0.1:8080/brew/bottles/sandcastle--0.3.0.loongarch64.bottle.tar.gz"
  sha256 "5ca28257592cd92ef1497d03869f1ad046abfbadfa858bdd06a0bc51b186d9b8"

  def install
    bin.install "sandcastle"
  end

  test do
    system "#{bin}/sandcastle"
  end
end
