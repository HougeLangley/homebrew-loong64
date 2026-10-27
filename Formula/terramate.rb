class Terramate < Formula
  desc "Managing Terraform stacks with change detections and code generations"
  homepage "https://example.org/terramate"
  version "0.17.3"
  url "http://127.0.0.1:8080/brew/bottles/terramate--0.17.3.loongarch64.bottle.tar.gz"
  sha256 "41f90339ffa2ea12e139e8e15081200e02499f53138879bf239fae1eace93610"

  def install
    bin.install "terramate"
  end

  test do
    system "#{bin}/terramate"
  end
end
