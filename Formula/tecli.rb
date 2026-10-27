class Tecli < Formula
  desc "In a world where everything is Terraform, teams use Terraform Cloud API to manage their wo"
  homepage "https://example.org/tecli"
  version "0.5.0-alpha"
  url "http://127.0.0.1:8080/brew/bottles/tecli--0.5.0-alpha.loongarch64.bottle.tar.gz"
  sha256 "0909e86da7c573807c0b6ba4025ce950d5105eb0e67251e4fff760c0b626fb5a"

  def install
    bin.install "tecli"
  end

  test do
    system "#{bin}/tecli"
  end
end
