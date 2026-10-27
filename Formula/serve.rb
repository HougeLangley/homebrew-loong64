class Serve < Formula
  desc "🍽️ a static http server anywhere you need one."
  homepage "https://example.org/serve"
  version "0.8.0"
  url "http://127.0.0.1:8080/brew/bottles/serve--0.8.0.loongarch64.bottle.tar.gz"
  sha256 "8bc0b8835b582fc337d92fcf1daa0c5cae15b2a8222de8d89876bd2e2324d48d"

  def install
    bin.install "serve"
  end

  test do
    system "#{bin}/serve"
  end
end
