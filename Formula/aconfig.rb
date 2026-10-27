class Aconfig < Formula
  desc "Simple, useful and opinionated config loader."
  homepage "https://example.org/aconfig"
  version "0.19.0"
  url "http://127.0.0.1:8080/brew/bottles/aconfig--0.19.0.loongarch64.bottle.tar.gz"
  sha256 "dca5b5b860ba515c85383e9b5a605442f51ad3fc1da5a777e4b08c972e2948cb"

  def install
    bin.install "aconfig"
  end

  test do
    system "#{bin}/aconfig"
  end
end
