class Nuclei < Formula
  desc "Nuclei is a fast, customizable vulnerability scanner powered by the global security commun"
  homepage "https://example.org/nuclei"
  version "3.11.1"
  url "http://127.0.0.1:8080/brew/bottles/nuclei--3.11.1.loongarch64.bottle.tar.gz"
  sha256 "1a0e615520e673bfa34ee39d0977e39e76f7ae71ed007902126603f41749e8ac"

  def install
    bin.install "nuclei"
  end

  test do
    system "#{bin}/nuclei"
  end
end
