class Spdx-sbom-generator < Formula
  desc "Support CI generation of SBOMs via golang tooling"
  homepage "https://example.org/spdx-sbom-generator"
  version "0.0.15"
  url "http://127.0.0.1:8080/brew/bottles/spdx-sbom-generator--0.0.15.loongarch64.bottle.tar.gz"
  sha256 "30d49097ba2d01fd5185dc9a2201503d6b6e2f7dfa708ac5e6937dca610db537"

  def install
    bin.install "spdx-sbom-generator"
  end

  test do
    system "#{bin}/spdx-sbom-generator"
  end
end
