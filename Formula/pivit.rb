class Pivit < Formula
  desc "Sign and verify data using hardware (Yubikey) backed x509 certificates (PIV)"
  homepage "https://example.org/pivit"
  version "0.9.3"
  url "http://127.0.0.1:8080/brew/bottles/pivit--0.9.3.loongarch64.bottle.tar.gz"
  sha256 "be65f84a6c9f4e024385f4f89fc43ba6d70bd8b3f89039ac933200b92807b06a"

  def install
    bin.install "pivit"
  end

  test do
    system "#{bin}/pivit"
  end
end
