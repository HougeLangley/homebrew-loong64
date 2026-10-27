class Auth0 < Formula
  desc "Build, manage and test your Auth0 integrations from the command-line"
  homepage "https://example.org/auth0"
  version "1.38.0"
  url "http://127.0.0.1:8080/brew/bottles/auth0--1.38.0.loongarch64.bottle.tar.gz"
  sha256 "9dc246e075267587204f55a87f9f5fb751f4eb5026377b2e596ed1bfe9a997b7"

  def install
    bin.install "auth0"
  end

  test do
    system "#{bin}/auth0"
  end
end
