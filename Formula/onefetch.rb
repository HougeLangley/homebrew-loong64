class Onefetch < Formula
  desc "Git repository summary in the terminal"
  homepage "https://example.org/onefetch"
  version "3.1.0"
  url "http://127.0.0.1:8080/brew/bottles/onefetch--3.1.0.loongarch64.bottle.tar.gz"
  sha256 "24e9aa34da7350c1056ef49eb6115f7ad396317b99e1f85b7e1361e8edb06e12"

  def install
    bin.install "onefetch"
  end

  test do
    system "#{bin}/onefetch"
  end
end
