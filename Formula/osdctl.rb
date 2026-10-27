class Osdctl < Formula
  desc "CLI tool for managed OpenShift clusters"
  homepage "https://example.org/osdctl"
  version "0.66.0"
  url "http://127.0.0.1:8080/brew/bottles/osdctl--0.66.0.loongarch64.bottle.tar.gz"
  sha256 "839a85174459f9db191e1e3499c41c3ba82a1e52cfe890079dbf1a7988f76ba9"

  def install
    bin.install "osdctl"
  end

  test do
    system "#{bin}/osdctl"
  end
end
