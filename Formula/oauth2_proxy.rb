class Oauth2_proxy < Formula
  desc "Reverse proxy for authenticating users via OAuth 2 providers"
  homepage "https://example.org/oauth2_proxy"
  version "7.15.5"
  url "http://127.0.0.1:8080/brew/bottles/oauth2_proxy--7.15.5.loongarch64.bottle.tar.gz"
  sha256 "242310ac91e2d863d2f97e8ad06acc571cd5e0e08d2f88f204fee9c52f8f7f3f"

  def install
    bin.install "oauth2_proxy"
  end

  test do
    system "#{bin}/oauth2_proxy"
  end
end
