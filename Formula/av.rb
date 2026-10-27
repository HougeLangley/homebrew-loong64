class Av < Formula
  desc "A command line tool to manage stacked PRs with Aviator"
  homepage "https://example.org/av"
  version "0.1.48"
  url "http://127.0.0.1:8080/brew/bottles/av--0.1.48.loongarch64.bottle.tar.gz"
  sha256 "1060af72572ab26d7b689b4b7d71457d6603ec6bed3a37d2f57c2440a9554cb0"

  def install
    bin.install "av"
  end

  test do
    system "#{bin}/av"
  end
end
