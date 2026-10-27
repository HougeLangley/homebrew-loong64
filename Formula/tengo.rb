class Tengo < Formula
  desc "Fast script language for Go"
  homepage "https://example.org/tengo"
  version "3.0.0"
  url "http://127.0.0.1:8080/brew/bottles/tengo--3.0.0.loongarch64.bottle.tar.gz"
  sha256 "f59609e7b85dc78e35ee2b4283227f6a9e17feff2b6070c44daa8098ffb61b6d"

  def install
    bin.install "tengo"
  end

  test do
    system "#{bin}/tengo"
  end
end
