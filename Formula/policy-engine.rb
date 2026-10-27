class Policy-engine < Formula
  desc "Unified Policy Engine"
  homepage "https://example.org/policy-engine"
  version "1.1.7"
  url "http://127.0.0.1:8080/brew/bottles/policy-engine--1.1.7.loongarch64.bottle.tar.gz"
  sha256 "59bcc878e9f7e2e2009d1e2d1699c9becff3c6f5f25bf11004f955dd6740fd84"

  def install
    bin.install "policy-engine"
  end

  test do
    system "#{bin}/policy-engine"
  end
end
