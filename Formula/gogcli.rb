class Gogcli < Formula
  desc "Google Suite CLI"
  homepage "https://example.org/gogcli"
  version "0.47.1"
  url "http://127.0.0.1:8080/brew/bottles/gogcli--0.47.1.loongarch64.bottle.tar.gz"
  sha256 "21c4b9a6241c54ecabeef10ebb7954ec4c2aeb19ff8565c4c90c8555129c5186"

  def install
    bin.install "gogcli"
  end

  test do
    system "#{bin}/gogcli"
  end
end
