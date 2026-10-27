class Bomctl < Formula
  desc "Format-agnostic SBOM tooling for the stages between SBOM generation and analysis"
  homepage "https://example.org/bomctl"
  version "0.4.3"
  url "http://127.0.0.1:8080/brew/bottles/bomctl--0.4.3.loongarch64.bottle.tar.gz"
  sha256 "940306c9662ca1360b63cf196d807442523c2dbe690da54b9f112fa79c6ca057"

  def install
    bin.install "bomctl"
  end

  test do
    system "#{bin}/bomctl"
  end
end
