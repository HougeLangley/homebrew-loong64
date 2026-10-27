class Certificates < Formula
  desc "🛡️ A private certificate authority (X.509 & SSH) & ACME server for secure automated certif"
  homepage "https://example.org/certificates"
  version "0.30.2"
  url "http://127.0.0.1:8080/brew/bottles/certificates--0.30.2.loongarch64.bottle.tar.gz"
  sha256 "f6b31c2ca4d9c09963d02c38b764c9d090abc760943f441ad6d70dd867758166"

  def install
    bin.install "certificates"
  end

  test do
    system "#{bin}/certificates"
  end
end
