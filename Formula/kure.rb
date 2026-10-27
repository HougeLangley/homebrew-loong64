class Kure < Formula
  desc "CLI password manager with sessions"
  homepage "https://example.org/kure"
  version "1.3.0"
  url "http://127.0.0.1:8080/brew/bottles/kure--1.3.0.loongarch64.bottle.tar.gz"
  sha256 "dd6d792b5e5de6fcb9dc2e79195e72f1a2ef34ec2656b90b93b2ac661b9fc346"

  def install
    bin.install "kure"
  end

  test do
    system "#{bin}/kure"
  end
end
