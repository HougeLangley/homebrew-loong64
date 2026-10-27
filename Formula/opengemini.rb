class Opengemini < Formula
  desc "CNCF sandbox project, an open source distributed time-series database with high concurrenc"
  homepage "https://example.org/opengemini"
  version "1.5.2"
  url "http://127.0.0.1:8080/brew/bottles/opengemini--1.5.2.loongarch64.bottle.tar.gz"
  sha256 "d02cc28200194a49bd9d2a9d420407bdd664a77c3da00fe0130586458363c94d"

  def install
    bin.install "opengemini"
  end

  test do
    system "#{bin}/opengemini"
  end
end
