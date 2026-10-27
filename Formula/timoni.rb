class Timoni < Formula
  desc "Package manager for Kubernetes, powered by CUE and inspired by Helm"
  homepage "https://example.org/timoni"
  version "0.36.0"
  url "http://127.0.0.1:8080/brew/bottles/timoni--0.36.0.loongarch64.bottle.tar.gz"
  sha256 "8a8d9719e2c2ff138554a188ffa1a6da844e98046e98a117a4c904d9f812b5dd"

  def install
    bin.install "timoni"
  end

  test do
    system "#{bin}/timoni"
  end
end
