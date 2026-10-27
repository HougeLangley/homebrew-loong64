class V2ray < Formula
  desc "Platform for building proxies to bypass network restrictions"
  homepage "https://example.org/v2ray"
  version "5.53.0"
  url "http://127.0.0.1:8080/brew/bottles/v2ray--5.53.0.loongarch64.bottle.tar.gz"
  sha256 "943d372340795449aa991268b1ee17d91712173b3552448131c24c9a1fb814fc"

  def install
    bin.install "v2ray"
  end

  test do
    system "#{bin}/v2ray"
  end
end
