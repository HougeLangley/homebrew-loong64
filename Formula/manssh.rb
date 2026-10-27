class Manssh < Formula
  desc "Manage your ssh alias configs easily."
  homepage "https://example.org/manssh"
  version "0.5.3"
  url "http://127.0.0.1:8080/brew/bottles/manssh--0.5.3.loongarch64.bottle.tar.gz"
  sha256 "bf35b2b22da608c8391c0e62919ebb59150648a2d84646eaf7f86f745945ebcf"

  def install
    bin.install "manssh"
  end

  test do
    system "#{bin}/manssh"
  end
end
