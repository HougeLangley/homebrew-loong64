class Kruise < Formula
  desc "Automated management of large-scale applications on Kubernetes (incubating project under C"
  homepage "https://example.org/kruise"
  version "1.9.2"
  url "http://127.0.0.1:8080/brew/bottles/kruise--1.9.2.loongarch64.bottle.tar.gz"
  sha256 "a5cced8419d1b02f3f579f04cc3b5d5714aa596259b02b52e6d72c37ee458af5"

  def install
    bin.install "kruise"
  end

  test do
    system "#{bin}/kruise"
  end
end
