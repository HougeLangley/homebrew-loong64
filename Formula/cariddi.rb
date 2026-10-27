class Cariddi < Formula
  desc "Take a list of domains, crawl urls and scan for endpoints, secrets, api keys, file extensi"
  homepage "https://example.org/cariddi"
  version "1.4.6"
  url "http://127.0.0.1:8080/brew/bottles/cariddi--1.4.6.loongarch64.bottle.tar.gz"
  sha256 "b325a27c3b77345e76875533b622ebda2bcb14ad5e32850d4ee24dbae6a29dc2"

  def install
    bin.install "cariddi"
  end

  test do
    system "#{bin}/cariddi"
  end
end
