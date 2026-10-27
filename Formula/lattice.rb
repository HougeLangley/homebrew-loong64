class Lattice < Formula
  desc "A modular terminal dashboard built with Go and Bubble Tea"
  homepage "https://example.org/lattice"
  version "0.1.0"
  url "http://127.0.0.1:8080/brew/bottles/lattice--0.1.0.loongarch64.bottle.tar.gz"
  sha256 "693f5a99b554c28d474fc2f246f05a8aa4bf9141ed6c57da5dda68c406ff3b53"

  def install
    bin.install "lattice"
  end

  test do
    system "#{bin}/lattice"
  end
end
