class Terramate < Formula
  desc "Managing Terraform stacks with change detections and code generations"
  homepage "https://example.org/terramate"
  version "0.17.3"
  url "http://127.0.0.1:8080/brew/bottles/terramate--0.17.3.loongarch64.bottle.tar.gz"
  sha256 "2d216dc96c2b2d324547477bad620ae2d59b09f27f2ad31930768f24e933a5bc"

  def install
    bin.install "terramate"
  end

  test do
    system "#{bin}/terramate"
  end
end
