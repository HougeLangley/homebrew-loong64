class K3sup < Formula
  desc "bootstrap K3s over SSH in < 60s 🚀"
  homepage "https://example.org/k3sup"
  version "0.13.14"
  url "http://127.0.0.1:8080/brew/bottles/k3sup--0.13.14.loongarch64.bottle.tar.gz"
  sha256 "549c2915bc98453f9408114561a136e2e78913f71cc911327e87adaa0d2aba23"

  def install
    bin.install "k3sup"
  end

  test do
    system "#{bin}/k3sup"
  end
end
