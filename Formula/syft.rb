class Syft < Formula
  desc "CLI tool and library for generating a Software Bill of Materials from container images and"
  homepage "https://example.org/syft"
  version "1.55.0"
  url "http://127.0.0.1:8080/brew/bottles/syft--1.55.0.loongarch64.bottle.tar.gz"
  sha256 "e220bb626434e813e963d93c713011c1e5d9f5b8d2538166abd2bfdbdd8fdf6b"

  def install
    bin.install "syft"
  end

  test do
    system "#{bin}/syft"
  end
end
