class Fosite < Formula
  desc "Extensible security first OAuth 2.0 and OpenID Connect SDK for Go."
  homepage "https://example.org/fosite"
  version "0.49.0"
  url "http://127.0.0.1:8080/brew/bottles/fosite--0.49.0.loongarch64.bottle.tar.gz"
  sha256 "58e3cd6bac3250a5f37762eff303f4bebe2e10c2474d25db255a5b2da0bb1aeb"

  def install
    bin.install "fosite"
  end

  test do
    system "#{bin}/fosite"
  end
end
