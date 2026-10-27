class Jumppad < Formula
  desc "Modern cloud native development environments"
  homepage "https://example.org/jumppad"
  version "0.28.1"
  url "http://127.0.0.1:8080/brew/bottles/jumppad--0.28.1.loongarch64.bottle.tar.gz"
  sha256 "1e6cc5dcb3af4b9bd00ad875980c0b1da1d2987b1d18dee49cb65be527aaf1fd"

  def install
    bin.install "jumppad"
  end

  test do
    system "#{bin}/jumppad"
  end
end
