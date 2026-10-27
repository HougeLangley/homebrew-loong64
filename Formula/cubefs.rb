class Cubefs < Formula
  desc "cloud-native distributed storage"
  homepage "https://example.org/cubefs"
  version "3.6.0"
  url "http://127.0.0.1:8080/brew/bottles/cubefs--3.6.0.loongarch64.bottle.tar.gz"
  sha256 "649d1c5742234ee38492b92b69022239966c5294f7d39368ebf1b5e5450e11e3"

  def install
    bin.install "cubefs"
  end

  test do
    system "#{bin}/cubefs"
  end
end
