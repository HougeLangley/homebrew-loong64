class Helm-ls < Formula
  desc "Language server for Helm"
  homepage "https://example.org/helm-ls"
  version "0.5.4"
  url "http://127.0.0.1:8080/brew/bottles/helm-ls--0.5.4.loongarch64.bottle.tar.gz"
  sha256 "023032a248aa8357427dbcb7ea602a48588441b2421b723bb2c70b0b3b697f78"

  def install
    bin.install "helm-ls"
  end

  test do
    system "#{bin}/helm-ls"
  end
end
