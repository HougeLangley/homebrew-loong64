class Fx < Formula
  desc "Terminal JSON viewer"
  homepage "https://example.org/fx"
  version "40.0.1"
  url "http://127.0.0.1:8080/brew/bottles/fx--40.0.1.loongarch64.bottle.tar.gz"
  sha256 "818d0d9480db56348231129815370dd3d9ad15e57c3d8448df8c9b2483ad586d"

  def install
    bin.install "fx"
  end

  test do
    system "#{bin}/fx"
  end
end
