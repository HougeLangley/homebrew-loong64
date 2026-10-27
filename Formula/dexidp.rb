class Dexidp < Formula
  desc "OpenID Connect Identity and OAuth 2.0 Provider"
  homepage "https://example.org/dexidp"
  version "2.46.1"
  url "http://127.0.0.1:8080/brew/bottles/dexidp--2.46.1.loongarch64.bottle.tar.gz"
  sha256 "7aa30ad10bf9eb511dd3a7cc714a8728330db52264b83ac58bfdac6e6187a993"

  def install
    bin.install "dexidp"
  end

  test do
    system "#{bin}/dexidp"
  end
end
