class Bosh-cli < Formula
  desc "Cloud Foundry BOSH CLI v2"
  homepage "https://example.org/bosh-cli"
  version "7.11.2"
  url "http://127.0.0.1:8080/brew/bottles/bosh-cli--7.11.2.loongarch64.bottle.tar.gz"
  sha256 "733464cc90186d9233da1e4b48ab4c4c849be4750c81ad9871446e0e23164eec"

  def install
    bin.install "bosh-cli"
  end

  test do
    system "#{bin}/bosh-cli"
  end
end
