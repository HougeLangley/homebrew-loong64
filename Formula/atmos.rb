class Atmos < Formula
  desc "👽 Terraform Orchestration Tool for DevOps. Keep environment configuration DRY with hierarc"
  homepage "https://example.org/atmos"
  version "1.233.2"
  url "http://127.0.0.1:8080/brew/bottles/atmos--1.233.2.loongarch64.bottle.tar.gz"
  sha256 "29bf2e600b9495eebb3cb7aba315337c5dcb0f651b222826b48c60995fe32016"

  def install
    bin.install "atmos"
  end

  test do
    system "#{bin}/atmos"
  end
end
