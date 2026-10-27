class Apx < Formula
  desc "Apx (/à·peks/) is the default package manager in Vanilla OS. It is a wrapper around multip"
  homepage "https://example.org/apx"
  version "3.1.2"
  url "http://127.0.0.1:8080/brew/bottles/apx--3.1.2.loongarch64.bottle.tar.gz"
  sha256 "b179ee68ca4423b3d2629bd8325bb938f917c0cb19db572ff3a9f109df7d1c09"

  def install
    bin.install "apx"
  end

  test do
    system "#{bin}/apx"
  end
end
