class Terragrunt-atlantis-config < Formula
  desc "Generate Atlantis config for Terragrunt projects"
  homepage "https://example.org/terragrunt-atlantis-config"
  version "1.21.1"
  url "http://127.0.0.1:8080/brew/bottles/terragrunt-atlantis-config--1.21.1.loongarch64.bottle.tar.gz"
  sha256 "79a6fc2b5d07a2c1f80a05acef94b56ad6a53cf9dae2716e3c6208f09d46ef70"

  def install
    bin.install "terragrunt-atlantis-config"
  end

  test do
    system "#{bin}/terragrunt-atlantis-config"
  end
end
