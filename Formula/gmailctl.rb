class Gmailctl < Formula
  desc "Declarative configuration for Gmail filters"
  homepage "https://example.org/gmailctl"
  version "0.13.0"
  url "http://127.0.0.1:8080/brew/bottles/gmailctl--0.13.0.loongarch64.bottle.tar.gz"
  sha256 "b147b92f6622c2e00f59c81689f64ac91077605f04b588850c65f2ec807bcaaf"

  def install
    bin.install "gmailctl"
  end

  test do
    system "#{bin}/gmailctl"
  end
end
