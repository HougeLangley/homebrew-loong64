class Coder < Formula
  desc "Tool for provisioning self-hosted development environments with Terraform"
  homepage "https://example.org/coder"
  version "2.37.7"
  url "http://127.0.0.1:8080/brew/bottles/coder--2.37.7.loongarch64.bottle.tar.gz"
  sha256 "7afc248e22e5c022669fc9e86230f344f95022aca85aa5ec63c5a1f4adfa7768"

  def install
    bin.install "coder"
  end

  test do
    system "#{bin}/coder"
  end
end
