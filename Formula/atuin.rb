class Atuin < Formula
  desc "Magical shell history"
  homepage "https://example.org/atuin"
  version "18.24.2"
  url "http://127.0.0.1:8080/brew/bottles/atuin--18.24.2.loongarch64.bottle.tar.gz"
  sha256 "bf7a62f6ab9084cef41d3fe2f8524c630da5995f8dfc8f406f3f3a677de31168"

  def install
    bin.install "atuin"
  end

  test do
    system "#{bin}/atuin"
  end
end
