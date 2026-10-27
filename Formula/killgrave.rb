class Killgrave < Formula
  desc "Simple way to generate mock servers written in Go"
  homepage "https://example.org/killgrave"
  version "0.5.1"
  url "http://127.0.0.1:8080/brew/bottles/killgrave--0.5.1.loongarch64.bottle.tar.gz"
  sha256 "173b0b3e032b02b7765925e5545ad560886a736ec381451dee3cd55265389ca4"

  def install
    bin.install "killgrave"
  end

  test do
    system "#{bin}/killgrave"
  end
end
