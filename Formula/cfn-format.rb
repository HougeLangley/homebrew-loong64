class Cfn-format < Formula
  desc "Command-line tool for formatting AWS CloudFormation templates"
  homepage "https://example.org/cfn-format"
  version "1.24.4"
  url "http://127.0.0.1:8080/brew/bottles/cfn-format--1.24.4.loongarch64.bottle.tar.gz"
  sha256 "c71c7945efcb991271e4465eaf10603a7a28a0e7c5ba8105e7925980120342b9"

  def install
    bin.install "cfn-format"
  end

  test do
    system "#{bin}/cfn-format"
  end
end
