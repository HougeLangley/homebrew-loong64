class Proji < Formula
  desc "A powerful cross-platform project templating tool."
  homepage "https://example.org/proji"
  version "0.20.0"
  url "http://127.0.0.1:8080/brew/bottles/proji--0.20.0.loongarch64.bottle.tar.gz"
  sha256 "2d5adcb93477201a430a3c92215a5f2ee1cce0ec6f705456e4de9324e8328a9f"

  def install
    bin.install "proji"
  end

  test do
    system "#{bin}/proji"
  end
end
