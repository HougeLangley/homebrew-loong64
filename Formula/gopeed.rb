class Gopeed < Formula
  desc "Multi protocol download manager"
  homepage "https://example.org/gopeed"
  version "1.9.3"
  url "http://127.0.0.1:8080/brew/bottles/gopeed--1.9.3.loongarch64.bottle.tar.gz"
  sha256 "cd032a59c37e95ac878d2b4053cf04a381988cc3e209bd5b8dd9592400e7b489"

  def install
    bin.install "gopeed"
  end

  test do
    system "#{bin}/gopeed"
  end
end
