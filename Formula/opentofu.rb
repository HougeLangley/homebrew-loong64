class Opentofu < Formula
  desc "Drop-in replacement for Terraform. Infrastructure as Code Tool"
  homepage "https://example.org/opentofu"
  version "1.13.2"
  url "http://127.0.0.1:8080/brew/bottles/opentofu--1.13.2.loongarch64.bottle.tar.gz"
  sha256 "e6481707996fb15a9ddf9765a3166b2d0aafa32908c642419c6fbc1fea777433"

  def install
    bin.install "opentofu"
  end

  test do
    system "#{bin}/opentofu"
  end
end
