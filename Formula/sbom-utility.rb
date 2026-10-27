class Sbom-utility < Formula
  desc "Tool to validate, analyze, query and edit Software Bills of Materials (SBOMs)"
  homepage "https://example.org/sbom-utility"
  version "0.19.2"
  url "http://127.0.0.1:8080/brew/bottles/sbom-utility--0.19.2.loongarch64.bottle.tar.gz"
  sha256 "2f950e9eb56d9eb8374379444164b957a3384e33b14cb339c3a8e0fa21bc0010"

  def install
    bin.install "sbom-utility"
  end

  test do
    system "#{bin}/sbom-utility"
  end
end
