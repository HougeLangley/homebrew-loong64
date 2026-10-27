class Traefik < Formula
  desc "The Cloud Native Application Proxy"
  homepage "https://example.org/traefik"
  version "3.7.16"
  url "http://127.0.0.1:8080/brew/bottles/traefik--3.7.16.loongarch64.bottle.tar.gz"
  sha256 "44b0936e0382ddc220a307cb6df203ef326eca779636f6f315bb4f5b4e9a9d09"

  def install
    bin.install "traefik"
  end

  test do
    system "#{bin}/traefik"
  end
end
