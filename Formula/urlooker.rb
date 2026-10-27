class Urlooker < Formula
  desc "enterprise-level websites monitoring system"
  homepage "https://example.org/urlooker"
  version "V1.1.0"
  url "http://127.0.0.1:8080/brew/bottles/urlooker--V1.1.0.loongarch64.bottle.tar.gz"
  sha256 "2e54651e39563f8dae23ac13bfbaf8490a3442f847a3ca7fc236c597840f92e5"

  def install
    bin.install "urlooker"
  end

  test do
    system "#{bin}/urlooker"
  end
end
