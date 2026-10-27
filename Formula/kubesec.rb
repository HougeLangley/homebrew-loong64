class Kubesec < Formula
  desc "Security risk analysis for Kubernetes resources"
  homepage "https://example.org/kubesec"
  version "2.15.0"
  url "http://127.0.0.1:8080/brew/bottles/kubesec--2.15.0.loongarch64.bottle.tar.gz"
  sha256 "e66ba3bba077f66ad82283ce42f123f80f253760bd1cf80edc38f9062718d9ca"

  def install
    bin.install "kubesec"
  end

  test do
    system "#{bin}/kubesec"
  end
end
