class Oauth2_proxy < Formula
  desc "Reverse proxy for authenticating users via OAuth 2 providers"
  homepage "https://example.org/oauth2_proxy"
  version "7.15.5"
  url "http://127.0.0.1:8080/brew/bottles/oauth2_proxy--7.15.5.loongarch64.bottle.tar.gz"
  sha256 "06d7ad6292eed249aeefc2f06d03fb23dd53b5a936ae0454e4196eb0fa9066cd"

  def install
    bin.install "oauth2_proxy"
  end

  test do
    system "#{bin}/oauth2_proxy"
  end
end
