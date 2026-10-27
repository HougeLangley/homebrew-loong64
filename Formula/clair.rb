class Clair < Formula
  desc "Vulnerability Static Analysis for Containers"
  homepage "https://example.org/clair"
  version "4.9.0"
  url "http://127.0.0.1:8080/brew/bottles/clair--4.9.0.loongarch64.bottle.tar.gz"
  sha256 "234722365ed28c6da6616e35eddb7d25709889491018fa73da1f053b521b5081"

  def install
    bin.install "clair"
  end

  test do
    system "#{bin}/clair"
  end
end
