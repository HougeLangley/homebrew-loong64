class Flux2 < Formula
  desc "Open and extensible continuous delivery solution for Kubernetes. Powered by GitOps Toolkit"
  homepage "https://example.org/flux2"
  version "2.10.0"
  url "http://127.0.0.1:8080/brew/bottles/flux2--2.10.0.loongarch64.bottle.tar.gz"
  sha256 "2c4b5bc56a7e11616eb804af9f23ccbd54e4c537fd9dd529f6fb2dd14830456a"

  def install
    bin.install "flux2"
  end

  test do
    system "#{bin}/flux2"
  end
end
