class Lazycontainer < Formula
  desc "Terminal UI for Apple Containers"
  homepage "https://example.org/lazycontainer"
  version "0.0.2"
  url "http://127.0.0.1:8080/brew/bottles/lazycontainer--0.0.2.loongarch64.bottle.tar.gz"
  sha256 "6ff192c2eb73e0d3c0bb80e4873905add2533061a746baa4316f2636de605948"

  def install
    bin.install "lazycontainer"
  end

  test do
    system "#{bin}/lazycontainer"
  end
end
