class Gau < Formula
  desc "Fetch known URLs from AlienVault's Open Threat Exchange, the Wayback Machine, and Common C"
  homepage "https://example.org/gau"
  version "2.2.4"
  url "http://127.0.0.1:8080/brew/bottles/gau--2.2.4.loongarch64.bottle.tar.gz"
  sha256 "1b9fdfc26000a61d9b27574ea98a2838cf63cc0f113577364d954823077f95b1"

  def install
    bin.install "gau"
  end

  test do
    system "#{bin}/gau"
  end
end
