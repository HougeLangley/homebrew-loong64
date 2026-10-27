class Tfupdate < Formula
  desc "Update version constraints in your Terraform configurations"
  homepage "https://example.org/tfupdate"
  version "0.10.3"
  url "http://127.0.0.1:8080/brew/bottles/tfupdate--0.10.3.loongarch64.bottle.tar.gz"
  sha256 "f4dc5b8b8ff880da290fbe14d08408b884b55e0a84474a782bb42d67ea58e0dd"

  def install
    bin.install "tfupdate"
  end

  test do
    system "#{bin}/tfupdate"
  end
end
