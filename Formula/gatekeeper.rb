class Gatekeeper < Formula
  desc "🐊 Policy Controller for Kubernetes"
  homepage "https://example.org/gatekeeper"
  version "3.23.1"
  url "http://127.0.0.1:8080/brew/bottles/gatekeeper--3.23.1.loongarch64.bottle.tar.gz"
  sha256 "e9362d007a8e093d53e8c0dd244771877a0f8820a360adffea08283f03105757"

  def install
    bin.install "gatekeeper"
  end

  test do
    system "#{bin}/gatekeeper"
  end
end
