class Ksops < Formula
  desc "Flexible Kustomize Plugin for SOPS Encrypted Resources"
  homepage "https://example.org/ksops"
  version "4.5.1"
  url "http://127.0.0.1:8080/brew/bottles/ksops--4.5.1.loongarch64.bottle.tar.gz"
  sha256 "10072ea7961f83b2d959c28de789a9ebeb34d9479a515887ae6db30a613329a2"

  def install
    bin.install "ksops"
  end

  test do
    system "#{bin}/ksops"
  end
end
