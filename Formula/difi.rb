class Difi < Formula
  desc "Review and refine Git diffs before you push"
  homepage "https://example.org/difi"
  version "0.2.31"
  url "http://127.0.0.1:8080/brew/bottles/difi--0.2.31.loongarch64.bottle.tar.gz"
  sha256 "da15da2feb4807b46374e23ba352fcdf1c621fca685b66ea579214d5f6399402"

  def install
    bin.install "difi"
  end

  test do
    system "#{bin}/difi"
  end
end
