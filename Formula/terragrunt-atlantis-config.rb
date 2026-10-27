class Terragrunt-atlantis-config < Formula
  desc "Generate Atlantis config for Terragrunt projects"
  homepage "https://example.org/terragrunt-atlantis-config"
  version "1.21.1"
  url "http://127.0.0.1:8080/brew/bottles/terragrunt-atlantis-config--1.21.1.loongarch64.bottle.tar.gz"
  sha256 "9654c63ee59b6c96ef5c6bd197070821db28fc976dae5865653aa1f19e560f2c"

  def install
    bin.install "terragrunt-atlantis-config"
  end

  test do
    system "#{bin}/terragrunt-atlantis-config"
  end
end
