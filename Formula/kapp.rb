class Kapp < Formula
  desc "kapp is a simple deployment tool focused on the concept of Kubernetes"
  homepage "https://example.org/kapp"
  version "0.66.1"
  url "http://127.0.0.1:8080/brew/bottles/kapp--0.66.1.loongarch64.bottle.tar.gz"
  sha256 "8aa5ae48c13ce93727a636f8128be6a57269a1c83c09fcaed60acad2147a345b"

  def install
    bin.install "kapp"
  end

  test do
    system "#{bin}/kapp"
  end
end
