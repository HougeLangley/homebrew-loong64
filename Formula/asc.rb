class Asc < Formula
  desc "Fast, lightweight CLI for App Store Connect"
  homepage "https://example.org/asc"
  version "5.17.1"
  url "http://127.0.0.1:8080/brew/bottles/asc--5.17.1.loongarch64.bottle.tar.gz"
  sha256 "9cad9cb58b655d35119e19b180ae98154999970bd010088a66c05a7c0d180301"

  def install
    bin.install "asc"
  end

  test do
    system "#{bin}/asc"
  end
end
