class Infra < Formula
  desc "Infra provides authentication and access management to servers and Kubernetes clusters."
  homepage "https://example.org/infra"
  version "0.21.0"
  url "http://127.0.0.1:8080/brew/bottles/infra--0.21.0.loongarch64.bottle.tar.gz"
  sha256 "fab1ed2617977527360d6e6630e157fc1d8cff2d40e9a16141d3f1d22958b9a0"

  def install
    bin.install "infra"
  end

  test do
    system "#{bin}/infra"
  end
end
