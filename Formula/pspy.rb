class Pspy < Formula
  desc "Monitor linux processes without root permissions"
  homepage "https://example.org/pspy"
  version "1.2.1"
  url "http://127.0.0.1:8080/brew/bottles/pspy--1.2.1.loongarch64.bottle.tar.gz"
  sha256 "706f99d49531933de032d242615482b856b03bbc38dba283e22a6dcd9b29ee12"

  def install
    bin.install "pspy"
  end

  test do
    system "#{bin}/pspy"
  end
end
