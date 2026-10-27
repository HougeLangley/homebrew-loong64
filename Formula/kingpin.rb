class Kingpin < Formula
  desc "CONTRIBUTIONS ONLY: A Go (golang) command line and flag parser"
  homepage "https://example.org/kingpin"
  version "2.4.0"
  url "http://127.0.0.1:8080/brew/bottles/kingpin--2.4.0.loongarch64.bottle.tar.gz"
  sha256 "e8142f971dad23ed6a128cdc9908838545519edd17c11fb05f69a6c134cd6699"

  def install
    bin.install "kingpin"
  end

  test do
    system "#{bin}/kingpin"
  end
end
