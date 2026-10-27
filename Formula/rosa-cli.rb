class Rosa-cli < Formula
  desc "RedHat OpenShift Service on AWS (ROSA) command-line interface"
  homepage "https://example.org/rosa-cli"
  version "1.2.67"
  url "http://127.0.0.1:8080/brew/bottles/rosa-cli--1.2.67.loongarch64.bottle.tar.gz"
  sha256 "7237aa111b7033ebf66c0ffcfa58cebc24248fec02a34b2d5429a580aebae888"

  def install
    bin.install "rosa-cli"
  end

  test do
    system "#{bin}/rosa-cli"
  end
end
