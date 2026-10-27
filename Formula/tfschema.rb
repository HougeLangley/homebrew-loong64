class Tfschema < Formula
  desc "Schema inspector for Terraform/OpenTofu providers"
  homepage "https://example.org/tfschema"
  version "0.7.10"
  url "http://127.0.0.1:8080/brew/bottles/tfschema--0.7.10.loongarch64.bottle.tar.gz"
  sha256 "74589863133cc9570c684477bb7ea460dbcdde8235b733cace3f9784dabba59d"

  def install
    bin.install "tfschema"
  end

  test do
    system "#{bin}/tfschema"
  end
end
