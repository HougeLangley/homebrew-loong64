class Trivy < Formula
  desc "Find vulnerabilities, misconfigurations, secrets, SBOM in containers, Kubernetes, code rep"
  homepage "https://example.org/trivy"
  version "0.76.1"
  url "http://127.0.0.1:8080/brew/bottles/trivy--0.76.1.loongarch64.bottle.tar.gz"
  sha256 "51cd62a278298e7b436ef88b23941aa0e1390907b27db5a836c1cb6cf84c21c5"

  def install
    bin.install "trivy"
  end

  test do
    system "#{bin}/trivy"
  end
end
