class External-dns < Formula
  desc "Configure external DNS servers dynamically from Kubernetes resources"
  homepage "https://example.org/external-dns"
  version "0.24.0"
  url "http://127.0.0.1:8080/brew/bottles/external-dns--0.24.0.loongarch64.bottle.tar.gz"
  sha256 "3a00c2ccd5150b8b5ed7ed6240830831338399edc3a34a793afa88f74ca5d6cc"

  def install
    bin.install "external-dns"
  end

  test do
    system "#{bin}/external-dns"
  end
end
