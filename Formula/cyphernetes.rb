class Cyphernetes < Formula
  desc "Kubernetes Query Language"
  homepage "https://example.org/cyphernetes"
  version "0.18.2"
  url "http://127.0.0.1:8080/brew/bottles/cyphernetes--0.18.2.loongarch64.bottle.tar.gz"
  sha256 "677e0d3611c25cbad485d8ab94975a89b9a8b934c64d51aa85fbc49b2de3a86d"

  def install
    bin.install "cyphernetes"
  end

  test do
    system "#{bin}/cyphernetes"
  end
end
