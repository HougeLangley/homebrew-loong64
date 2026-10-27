class Ghr < Formula
  desc "Upload multiple artifacts to GitHub Release in parallel"
  homepage "https://example.org/ghr"
  version "0.18.5"
  url "http://127.0.0.1:8080/brew/bottles/ghr--0.18.5.loongarch64.bottle.tar.gz"
  sha256 "4ca32e930c1166fbba8742697e227945f2f54e488ae1d3e7585c9fa3059af5ae"

  def install
    bin.install "ghr"
  end

  test do
    system "#{bin}/ghr"
  end
end
