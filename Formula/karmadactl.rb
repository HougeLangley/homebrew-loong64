class Karmadactl < Formula
  desc "CLI for Karmada control plane"
  homepage "https://example.org/karmadactl"
  version "1.19.0"
  url "http://127.0.0.1:8080/brew/bottles/karmadactl--1.19.0.loongarch64.bottle.tar.gz"
  sha256 "1a23bb5a0986345b3551c167c8d663439df55f338b766860aba11634c5915df5"

  def install
    bin.install "karmadactl"
  end

  test do
    system "#{bin}/karmadactl"
  end
end
