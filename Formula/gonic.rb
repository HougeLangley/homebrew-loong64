class Gonic < Formula
  desc "music streaming server / free-software subsonic server API implementation"
  homepage "https://example.org/gonic"
  version "0.23.0"
  url "http://127.0.0.1:8080/brew/bottles/gonic--0.23.0.loongarch64.bottle.tar.gz"
  sha256 "524e4d49ed352dce8b675c7451d8d675cadc2d4c1f3aa8f15130af43dc88f6fa"

  def install
    bin.install "gonic"
  end

  test do
    system "#{bin}/gonic"
  end
end
