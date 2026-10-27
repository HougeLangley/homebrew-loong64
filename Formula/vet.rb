class Vet < Formula
  desc "Policy driven vetting of open source dependencies"
  homepage "https://example.org/vet"
  version "1.20.0"
  url "http://127.0.0.1:8080/brew/bottles/vet--1.20.0.loongarch64.bottle.tar.gz"
  sha256 "6835b5540707b0fbfaacee3e01f99552fea49a4b8d95f3d98864bc930a5d49f1"

  def install
    bin.install "vet"
  end

  test do
    system "#{bin}/vet"
  end
end
