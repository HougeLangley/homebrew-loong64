class Topaz < Formula
  desc "Cloud-native authorization for modern applications and APIs"
  homepage "https://example.org/topaz"
  version "0.33.25"
  url "http://127.0.0.1:8080/brew/bottles/topaz--0.33.25.loongarch64.bottle.tar.gz"
  sha256 "68252fef57cea954fa36c83cc1e8a4a515e95c791cf47053dc0101cfa86b05c2"

  def install
    bin.install "topaz"
  end

  test do
    system "#{bin}/topaz"
  end
end
