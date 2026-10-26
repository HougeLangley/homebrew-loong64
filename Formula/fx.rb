class Fx < Formula
  desc "Terminal JSON viewer"
  homepage "https://example.org/fx"
  version "40.0.1"
  url "http://127.0.0.1:8080/brew/bottles/fx--40.0.1.loongarch64.bottle.tar.gz"
  sha256 "cea4830811013a7f66cd493cd74cc411335569b264267dffae7917f12d1bea9c"

  def install
    bin.install "fx"
  end

  test do
    system "#{bin}/fx"
  end
end
