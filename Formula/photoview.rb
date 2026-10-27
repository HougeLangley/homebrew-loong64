class Photoview < Formula
  desc "Photo gallery for self-hosted personal servers"
  homepage "https://example.org/photoview"
  version "2.4.0"
  url "http://127.0.0.1:8080/brew/bottles/photoview--2.4.0.loongarch64.bottle.tar.gz"
  sha256 "e649612afe753f140eced19d73b76116d05d224383b19b28c156fb551ccd7aa7"

  def install
    bin.install "photoview"
  end

  test do
    system "#{bin}/photoview"
  end
end
