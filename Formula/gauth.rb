class Gauth < Formula
  desc "Google Authenticator in your terminal"
  homepage "https://example.org/gauth"
  version "1.5.0"
  url "http://127.0.0.1:8080/brew/bottles/gauth--1.5.0.loongarch64.bottle.tar.gz"
  sha256 "dd0394b261c9e37e66b09048726f1923629526dfe87688ed1133d3525802627a"

  def install
    bin.install "gauth"
  end

  test do
    system "#{bin}/gauth"
  end
end
