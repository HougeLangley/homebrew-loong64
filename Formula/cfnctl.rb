class Cfnctl < Formula
  desc "Brings the Terraform cli experience to AWS Cloudformation"
  homepage "https://example.org/cfnctl"
  version "0.1.1"
  url "http://127.0.0.1:8080/brew/bottles/cfnctl--0.1.1.loongarch64.bottle.tar.gz"
  sha256 "077a0df61d01f8a9a336256b02f306ed2c9980d8a45c62c19137ec41f948ef42"

  def install
    bin.install "cfnctl"
  end

  test do
    system "#{bin}/cfnctl"
  end
end
