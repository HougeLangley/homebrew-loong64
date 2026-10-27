class Go-feature-flag-relay-proxy < Formula
  desc "Stand alone server to run GO Feature Flag"
  homepage "https://example.org/go-feature-flag-relay-proxy"
  version "1.57.2"
  url "http://127.0.0.1:8080/brew/bottles/go-feature-flag-relay-proxy--1.57.2.loongarch64.bottle.tar.gz"
  sha256 "dfed79ef5b430570ec2c0eb2c2f5802c050c95b4011ee9d65d620dcc94612a23"

  def install
    bin.install "go-feature-flag-relay-proxy"
  end

  test do
    system "#{bin}/go-feature-flag-relay-proxy"
  end
end
