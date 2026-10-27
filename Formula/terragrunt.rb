class Terragrunt < Formula
  desc "Terragrunt is a flexible orchestration tool that allows Infrastructure as Code written in "
  homepage "https://example.org/terragrunt"
  version "1.2.1"
  url "http://127.0.0.1:8080/brew/bottles/terragrunt--1.2.1.loongarch64.bottle.tar.gz"
  sha256 "0b27c6870d7c083579acd5cc33dff12a762678034492f17d6f6a802e2258c083"

  def install
    bin.install "terragrunt"
  end

  test do
    system "#{bin}/terragrunt"
  end
end
