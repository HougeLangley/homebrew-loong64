class Aztfexport < Formula
  desc "A tool to bring existing Azure resources under Terraform's management"
  homepage "https://example.org/aztfexport"
  version "0.20.0"
  url "http://127.0.0.1:8080/brew/bottles/aztfexport--0.20.0.loongarch64.bottle.tar.gz"
  sha256 "870e87843cec294897ae37b2acac6b884d0f68b45b2a521e40eb30b2f339df01"

  def install
    bin.install "aztfexport"
  end

  test do
    system "#{bin}/aztfexport"
  end
end
