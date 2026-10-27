class Kubefwd < Formula
  desc "Bulk port forwarding Kubernetes services for local development."
  homepage "https://example.org/kubefwd"
  version "1.25.18"
  url "http://127.0.0.1:8080/brew/bottles/kubefwd--1.25.18.loongarch64.bottle.tar.gz"
  sha256 "004567314fcc08cdf696cd9c8e636ea3795eab9ac2d372d2d3fde41b55165e8a"

  def install
    bin.install "kubefwd"
  end

  test do
    system "#{bin}/kubefwd"
  end
end
