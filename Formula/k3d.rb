class K3d < Formula
  desc "Little helper to run CNCF's k3s in Docker"
  homepage "https://example.org/k3d"
  version "5.9.0"
  url "http://127.0.0.1:8080/brew/bottles/k3d--5.9.0.loongarch64.bottle.tar.gz"
  sha256 "ec62464e877a1b8e6b0dbdd5e7949341b481b1b6044a43354b8955a34f1521c1"

  def install
    bin.install "k3d"
  end

  test do
    system "#{bin}/k3d"
  end
end
