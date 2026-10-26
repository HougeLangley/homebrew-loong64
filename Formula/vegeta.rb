class Vegeta < Formula
  desc "HTTP load testing tool"
  homepage "https://example.org/vegeta"
  version "12.13.0"
  url "http://127.0.0.1:8080/brew/bottles/vegeta--12.13.0.loongarch64.bottle.tar.gz"
  sha256 "01754ff723770fbf772f05cb402e18651b19ba66d6e051bc640ad539619079e5"

  def install
    bin.install "vegeta"
  end

  test do
    system "#{bin}/vegeta"
  end
end
