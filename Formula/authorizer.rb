class Authorizer < Formula
  desc "Your data, your control. Fully open source, authentication and authorization. No lock-ins."
  homepage "https://example.org/authorizer"
  version "2.4.2"
  url "http://127.0.0.1:8080/brew/bottles/authorizer--2.4.2.loongarch64.bottle.tar.gz"
  sha256 "0b617eff7600811dd6ba87b8323ceb0913c08b7b41c9d0a44073076a8f61d03e"

  def install
    bin.install "authorizer"
  end

  test do
    system "#{bin}/authorizer"
  end
end
