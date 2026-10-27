class Gh < Formula
  desc "GitHub command-line tool"
  homepage "https://example.org/gh"
  version "2.103.3"
  url "http://127.0.0.1:8080/brew/bottles/gh--2.103.3.loongarch64.bottle.tar.gz"
  sha256 "0efac2c5701de9a85122839ad2b3e381da6cc51214401ca51a19a5b00a7f5b7e"

  def install
    bin.install "gh"
  end

  test do
    system "#{bin}/gh"
  end
end
