class Sift < Formula
  desc "Fast and powerful open source alternative to grep"
  homepage "https://example.org/sift"
  version "0.9.2"
  url "http://127.0.0.1:8080/brew/bottles/sift--0.9.2.loongarch64.bottle.tar.gz"
  sha256 "e9436d7ad813b76c6792ab65839c8319088e9239fad944c8aa0a266bc41c64d6"

  def install
    bin.install "sift"
  end

  test do
    system "#{bin}/sift"
  end
end
