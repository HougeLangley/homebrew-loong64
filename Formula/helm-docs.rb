class Helm-docs < Formula
  desc "Tool for automatically generating markdown documentation for helm charts"
  homepage "https://example.org/helm-docs"
  version "1.14.2"
  url "http://127.0.0.1:8080/brew/bottles/helm-docs--1.14.2.loongarch64.bottle.tar.gz"
  sha256 "f2bcfa2190dd9d994d72cde6eefb5cafea11fc00cc0633f5e7874fb766508627"

  def install
    bin.install "helm-docs"
  end

  test do
    system "#{bin}/helm-docs"
  end
end
