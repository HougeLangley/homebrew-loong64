class Helm < Formula
  desc "The Kubernetes Package Manager"
  homepage "https://example.org/helm"
  version "4.3.1"
  url "http://127.0.0.1:8080/brew/bottles/helm--4.3.1.loongarch64.bottle.tar.gz"
  sha256 "bf88b03097154a8325c175898f41f9b61b78dd5a085c5b8b20a4f7284b8fdd9d"

  def install
    bin.install "helm"
  end

  test do
    system "#{bin}/helm"
  end
end
