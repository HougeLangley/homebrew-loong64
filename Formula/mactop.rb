class Mactop < Formula
  desc "mactop - Apple Silicon Monitor Top"
  homepage "https://example.org/mactop"
  version "0.2.7"
  url "http://127.0.0.1:8080/brew/bottles/mactop--0.2.7.loongarch64.bottle.tar.gz"
  sha256 "6818e3c796f5727703d1626eb0a5ae490530624ab79e851dd2811997409f1c63"

  def install
    bin.install "mactop"
  end

  test do
    system "#{bin}/mactop"
  end
end
