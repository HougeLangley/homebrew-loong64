class Diffoci < Formula
  desc "Diff for Docker and OCI container images"
  homepage "https://example.org/diffoci"
  version "0.1.8"
  url "http://127.0.0.1:8080/brew/bottles/diffoci--0.1.8.loongarch64.bottle.tar.gz"
  sha256 "8056c4745ccb6784ec723025a8c15687fc075002d1d4fa6bef44b181652b2a2b"

  def install
    bin.install "diffoci"
  end

  test do
    system "#{bin}/diffoci"
  end
end
