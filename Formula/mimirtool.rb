class Mimirtool < Formula
  desc "CLI for interacting with Grafana Mimir"
  homepage "https://example.org/mimirtool"
  version "mimir-3.2.3"
  url "http://127.0.0.1:8080/brew/bottles/mimirtool--mimir-3.2.3.loongarch64.bottle.tar.gz"
  sha256 "3befe75d5c050cfcf099b71e1a3b77320a0e8d428db027e99e8a725df2029dc6"

  def install
    bin.install "mimirtool"
  end

  test do
    system "#{bin}/mimirtool"
  end
end
