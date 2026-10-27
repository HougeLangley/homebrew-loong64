class Gowsdl < Formula
  desc "WSDL2Go code generation as well as its SOAP proxy"
  homepage "https://example.org/gowsdl"
  version "0.3.1"
  url "http://127.0.0.1:8080/brew/bottles/gowsdl--0.3.1.loongarch64.bottle.tar.gz"
  sha256 "5a6ac32282cc664d9f47581101e2a96c50613e8633c99eff3370900c0cb8d3a7"

  def install
    bin.install "gowsdl"
  end

  test do
    system "#{bin}/gowsdl"
  end
end
