class Oslo < Formula
  desc "CLI tool for the OpenSLO spec"
  homepage "https://example.org/oslo"
  version "0.13.0"
  url "http://127.0.0.1:8080/brew/bottles/oslo--0.13.0.loongarch64.bottle.tar.gz"
  sha256 "f5e202d398123e349f927abc06f85dab42895bdba79d1652346811fb51f0a7e4"

  def install
    bin.install "oslo"
  end

  test do
    system "#{bin}/oslo"
  end
end
