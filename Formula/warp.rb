class Warp < Formula
  desc "Secure and simple terminal sharing"
  homepage "https://example.org/warp"
  version "0.0.3"
  url "http://127.0.0.1:8080/brew/bottles/warp--0.0.3.loongarch64.bottle.tar.gz"
  sha256 "93abadf1bbb49f2ea35192d2a620166829aa192749247d72ab107a7ed8019276"

  def install
    bin.install "warp"
  end

  test do
    system "#{bin}/warp"
  end
end
