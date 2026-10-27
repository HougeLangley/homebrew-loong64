class Of-watchdog < Formula
  desc "Reverse proxy/middleware for functions using STDIO/HTTP"
  homepage "https://example.org/of-watchdog"
  version "0.12.6"
  url "http://127.0.0.1:8080/brew/bottles/of-watchdog--0.12.6.loongarch64.bottle.tar.gz"
  sha256 "180cd96747459a73573061b5649addc05f3956916ec0da8175b619a50d37165d"

  def install
    bin.install "of-watchdog"
  end

  test do
    system "#{bin}/of-watchdog"
  end
end
