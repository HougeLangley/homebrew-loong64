class Ctlptl < Formula
  desc "Making local Kubernetes clusters fun and easy to set up"
  homepage "https://example.org/ctlptl"
  version "0.9.6"
  url "http://127.0.0.1:8080/brew/bottles/ctlptl--0.9.6.loongarch64.bottle.tar.gz"
  sha256 "58d1cac4d8782c80fa89737294e1f7215ad8614e6abfd5b92d4573de25108a3b"

  def install
    bin.install "ctlptl"
  end

  test do
    system "#{bin}/ctlptl"
  end
end
