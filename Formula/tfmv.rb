class Tfmv < Formula
  desc "CLI to rename Terraform resources and generate moved blocks"
  homepage "https://example.org/tfmv"
  version "1.0.1"
  url "http://127.0.0.1:8080/brew/bottles/tfmv--1.0.1.loongarch64.bottle.tar.gz"
  sha256 "8d8e85d493bead5015e648c0629f1bb198a20777628de6e45cdf51efba75407d"

  def install
    bin.install "tfmv"
  end

  test do
    system "#{bin}/tfmv"
  end
end
