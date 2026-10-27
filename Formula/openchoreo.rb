class Openchoreo < Formula
  desc "OpenChoreo is an internal developer platform for Kubernetes"
  homepage "https://example.org/openchoreo"
  version "1.3.2"
  url "http://127.0.0.1:8080/brew/bottles/openchoreo--1.3.2.loongarch64.bottle.tar.gz"
  sha256 "f16211567a041ba44a722f1a85a1c6eb53125ef4ee74503e79824be7765ab55d"

  def install
    bin.install "openchoreo"
  end

  test do
    system "#{bin}/openchoreo"
  end
end
