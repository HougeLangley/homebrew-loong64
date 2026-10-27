class Sonobuoy < Formula
  desc "Kubernetes component that generates reports on cluster conformance"
  homepage "https://example.org/sonobuoy"
  version "0.57.5"
  url "http://127.0.0.1:8080/brew/bottles/sonobuoy--0.57.5.loongarch64.bottle.tar.gz"
  sha256 "ec9147c1989b8b43958cf45ee9b7bff744dab3570b597c5518118c76359e0374"

  def install
    bin.install "sonobuoy"
  end

  test do
    system "#{bin}/sonobuoy"
  end
end
