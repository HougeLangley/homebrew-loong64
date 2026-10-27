class Terraboard < Formula
  desc ":earth_africa: :clipboard:  A web dashboard to inspect Terraform States "
  homepage "https://example.org/terraboard"
  version "2.4.0"
  url "http://127.0.0.1:8080/brew/bottles/terraboard--2.4.0.loongarch64.bottle.tar.gz"
  sha256 "ccf3ee52efdbe4e632350a15af09a498f24986935aa6e472d3f4c27300ded012"

  def install
    bin.install "terraboard"
  end

  test do
    system "#{bin}/terraboard"
  end
end
