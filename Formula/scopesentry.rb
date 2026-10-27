class Scopesentry < Formula
  desc "ScopeSentry-Cyberspace mapping, subdomain enumeration, port scanning, sensitive informatio"
  homepage "https://example.org/scopesentry"
  version "1.9.4"
  url "http://127.0.0.1:8080/brew/bottles/scopesentry--1.9.4.loongarch64.bottle.tar.gz"
  sha256 "5f13d44a21662bc394a5e3f5c6ae0bdffdff1403454b7daf492bcda1a2363773"

  def install
    bin.install "scopesentry"
  end

  test do
    system "#{bin}/scopesentry"
  end
end
