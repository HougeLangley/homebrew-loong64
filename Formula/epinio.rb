class Epinio < Formula
  desc "CLI for Epinio, the Application Development Engine for Kubernetes"
  homepage "https://example.org/epinio"
  version "1.14.3"
  url "http://127.0.0.1:8080/brew/bottles/epinio--1.14.3.loongarch64.bottle.tar.gz"
  sha256 "4893f505b4ee84230de553124199d99cbd919886f64e2bd50a72a868146f9ca7"

  def install
    bin.install "epinio"
  end

  test do
    system "#{bin}/epinio"
  end
end
