class Goread < Formula
  desc "RSS/Atom feeds in the terminal"
  homepage "https://example.org/goread"
  version "1.7.3"
  url "http://127.0.0.1:8080/brew/bottles/goread--1.7.3.loongarch64.bottle.tar.gz"
  sha256 "6625a127166e597abd4565467049cf9c37509103e5ed8be8abafadb790856952"

  def install
    bin.install "goread"
  end

  test do
    system "#{bin}/goread"
  end
end
