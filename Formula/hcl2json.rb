class Hcl2json < Formula
  desc "Convert HCL2 to JSON"
  homepage "https://example.org/hcl2json"
  version "0.6.9"
  url "http://127.0.0.1:8080/brew/bottles/hcl2json--0.6.9.loongarch64.bottle.tar.gz"
  sha256 "c0c38882dcdb9bf3a4e21feb882c2c97e2d7cf63448d9eb045d8545253fef0f9"

  def install
    bin.install "hcl2json"
  end

  test do
    system "#{bin}/hcl2json"
  end
end
