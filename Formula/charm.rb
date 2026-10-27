class Charm < Formula
  desc "Tool for managing Juju Charms"
  homepage "https://example.org/charm"
  version "2.5.2"
  url "http://127.0.0.1:8080/brew/bottles/charm--2.5.2.loongarch64.bottle.tar.gz"
  sha256 "457de347382ce5c1a8e882b192932f24e611ecf7dca1443a272b717ba2cf1c1a"

  def install
    bin.install "charm"
  end

  test do
    system "#{bin}/charm"
  end
end
