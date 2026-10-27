class Redli < Formula
  desc "Humane alternative to redis-cli with TLS support"
  homepage "https://example.org/redli"
  version "0.18.0"
  url "http://127.0.0.1:8080/brew/bottles/redli--0.18.0.loongarch64.bottle.tar.gz"
  sha256 "7db9046ef8df4695868fb851ce9dd70eccded3d0c8e07bf8d657b1d2a67713c4"

  def install
    bin.install "redli"
  end

  test do
    system "#{bin}/redli"
  end
end
