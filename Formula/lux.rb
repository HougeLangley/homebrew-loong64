class Lux < Formula
  desc "Fast and simple video downloader"
  homepage "https://example.org/lux"
  version "0.24.1"
  url "http://127.0.0.1:8080/brew/bottles/lux--0.24.1.loongarch64.bottle.tar.gz"
  sha256 "1e90922849dfced0372504b18da0e2cf6208cf07818c4baeef248ea4bb5df532"

  def install
    bin.install "lux"
  end

  test do
    system "#{bin}/lux"
  end
end
