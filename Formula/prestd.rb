class Prestd < Formula
  desc "Simplify and accelerate development on any Postgres application, existing or new"
  homepage "https://example.org/prestd"
  version "2.5.2"
  url "http://127.0.0.1:8080/brew/bottles/prestd--2.5.2.loongarch64.bottle.tar.gz"
  sha256 "44782215d84704c9617ec337153047cbb7ed1e4e06bb05e54c0dcb064d084467"

  def install
    bin.install "prestd"
  end

  test do
    system "#{bin}/prestd"
  end
end
