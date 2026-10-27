class Iam-policy-json-to-terraform < Formula
  desc "Convert a JSON IAM Policy into terraform"
  homepage "https://example.org/iam-policy-json-to-terraform"
  version "1.9.2"
  url "http://127.0.0.1:8080/brew/bottles/iam-policy-json-to-terraform--1.9.2.loongarch64.bottle.tar.gz"
  sha256 "230891e627233b982e6cbb0e374daa3cd2f0ab3dc31b04365604e6b1a0fd62fe"

  def install
    bin.install "iam-policy-json-to-terraform"
  end

  test do
    system "#{bin}/iam-policy-json-to-terraform"
  end
end
