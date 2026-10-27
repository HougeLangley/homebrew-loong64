class Qbec < Formula
  desc "Configure Kubernetes objects on multiple clusters using jsonnet"
  homepage "https://example.org/qbec"
  version "0.31.0"
  url "http://127.0.0.1:8080/brew/bottles/qbec--0.31.0.loongarch64.bottle.tar.gz"
  sha256 "b6450913347ec59d363338ccef9dd217ba108f82c27d134c68d0e1538e861b39"

  def install
    bin.install "qbec"
  end

  test do
    system "#{bin}/qbec"
  end
end
