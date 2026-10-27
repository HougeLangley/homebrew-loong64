class Nfpm < Formula
  desc "Simple deb and rpm packager"
  homepage "https://example.org/nfpm"
  version "2.48.0"
  url "http://127.0.0.1:8080/brew/bottles/nfpm--2.48.0.loongarch64.bottle.tar.gz"
  sha256 "be66c86c0b18ff8d33b5013aba94469cf0f183c04a13bef772c2dcd3029d3621"

  def install
    bin.install "nfpm"
  end

  test do
    system "#{bin}/nfpm"
  end
end
