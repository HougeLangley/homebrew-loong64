class Consul-template < Formula
  desc "Generic template rendering and notifications with Consul"
  homepage "https://example.org/consul-template"
  version "0.43.1"
  url "http://127.0.0.1:8080/brew/bottles/consul-template--0.43.1.loongarch64.bottle.tar.gz"
  sha256 "debdd44f55e8372e5700e7dc7e24a146ae4d612ef2e752e91d1cfa4d3f53282a"

  def install
    bin.install "consul-template"
  end

  test do
    system "#{bin}/consul-template"
  end
end
