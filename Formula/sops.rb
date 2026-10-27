class Sops < Formula
  desc "Simple and flexible tool for managing secrets"
  homepage "https://example.org/sops"
  version "3.13.3"
  url "http://127.0.0.1:8080/brew/bottles/sops--3.13.3.loongarch64.bottle.tar.gz"
  sha256 "fe0770ebb04ba527e9af073c00e4aa00774dd2b1cd9f0c520e43f484c0f4af02"

  def install
    bin.install "sops"
  end

  test do
    system "#{bin}/sops"
  end
end
