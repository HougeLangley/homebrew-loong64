class Bunster < Formula
  desc "Compile shell scripts to static binaries"
  homepage "https://example.org/bunster"
  version "0.14.0"
  url "http://127.0.0.1:8080/brew/bottles/bunster--0.14.0.loongarch64.bottle.tar.gz"
  sha256 "714ee5bf138a9589da081eaa17bf88176405cedcb7249238b090226b63dcad82"

  def install
    bin.install "bunster"
  end

  test do
    system "#{bin}/bunster"
  end
end
