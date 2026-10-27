class Ktop < Formula
  desc "Top-like tool for your Kubernetes clusters"
  homepage "https://example.org/ktop"
  version "0.5.3"
  url "http://127.0.0.1:8080/brew/bottles/ktop--0.5.3.loongarch64.bottle.tar.gz"
  sha256 "11b2e0ea925fadb70009489b80019fc8803e47c2f2a0f0325068ccab5c27acb4"

  def install
    bin.install "ktop"
  end

  test do
    system "#{bin}/ktop"
  end
end
