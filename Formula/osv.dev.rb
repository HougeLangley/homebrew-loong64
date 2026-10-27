class Osv.dev < Formula
  desc "Open source vulnerability DB and triage service."
  homepage "https://example.org/osv.dev"
  version "0.1.3"
  url "http://127.0.0.1:8080/brew/bottles/osv.dev--0.1.3.loongarch64.bottle.tar.gz"
  sha256 "7ac8b895604a188da3a454ef068cd98f61e86de0a657037b919e2a38fdb5b57d"

  def install
    bin.install "osv.dev"
  end

  test do
    system "#{bin}/osv.dev"
  end
end
