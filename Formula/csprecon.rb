class Csprecon < Formula
  desc "Discover new target domains using Content Security Policy"
  homepage "https://example.org/csprecon"
  version "0.4.7"
  url "http://127.0.0.1:8080/brew/bottles/csprecon--0.4.7.loongarch64.bottle.tar.gz"
  sha256 "ca412398b26fe22a8b3ab1666a7c28bb26c4868e45029fca45cb0931ef6b15c0"

  def install
    bin.install "csprecon"
  end

  test do
    system "#{bin}/csprecon"
  end
end
