class Kgateway < Formula
  desc "The Cloud-Native API Gateway and AI Gateway"
  homepage "https://example.org/kgateway"
  version "2.4.7"
  url "http://127.0.0.1:8080/brew/bottles/kgateway--2.4.7.loongarch64.bottle.tar.gz"
  sha256 "d6d490df592ae78c9b6fd8c40e5bc441e0ed64686609fa9ae04ae974371b6773"

  def install
    bin.install "kgateway"
  end

  test do
    system "#{bin}/kgateway"
  end
end
