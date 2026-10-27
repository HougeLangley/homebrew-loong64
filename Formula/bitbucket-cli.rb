class Bitbucket-cli < Formula
  desc "Bitbucket CLI with gh-like ergonomics"
  homepage "https://example.org/bitbucket-cli"
  version "0.37.0"
  url "http://127.0.0.1:8080/brew/bottles/bitbucket-cli--0.37.0.loongarch64.bottle.tar.gz"
  sha256 "4e66f2150619ef8cf503257d15bf21daac13a606488ae93a5ec84ec837e53e7c"

  def install
    bin.install "bitbucket-cli"
  end

  test do
    system "#{bin}/bitbucket-cli"
  end
end
