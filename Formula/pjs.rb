class Pjs < Formula
  desc "A basic CLI for regularly updating your project's status"
  homepage "https://example.org/pjs"
  version "0.1.0"
  url "http://127.0.0.1:8080/brew/bottles/pjs--0.1.0.loongarch64.bottle.tar.gz"
  sha256 "4df4a4c9d76e8ab3302d3de7cb6507624262e5e425266cc9f9148f11ec84ba4b"

  def install
    bin.install "pjs"
  end

  test do
    system "#{bin}/pjs"
  end
end
