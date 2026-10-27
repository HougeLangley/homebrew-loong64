class Doctl < Formula
  desc "The official command line interface for the DigitalOcean API."
  homepage "https://example.org/doctl"
  version "2.0.1"
  url "http://127.0.0.1:8080/brew/bottles/doctl--2.0.1.loongarch64.bottle.tar.gz"
  sha256 "34bca878ca165ac83b21bf8c4cdbacc954a514f93bc76035d21dd909555ee8d7"

  def install
    bin.install "doctl"
  end

  test do
    system "#{bin}/doctl"
  end
end
