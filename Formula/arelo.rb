class Arelo < Formula
  desc "Simple auto reload (live reload) utility"
  homepage "https://example.org/arelo"
  version "1.15.4"
  url "http://127.0.0.1:8080/brew/bottles/arelo--1.15.4.loongarch64.bottle.tar.gz"
  sha256 "d7f403f48fcb835bbdeb60ed892270c8732d396b71c5a39edf0145e8db4643f0"

  def install
    bin.install "arelo"
  end

  test do
    system "#{bin}/arelo"
  end
end
