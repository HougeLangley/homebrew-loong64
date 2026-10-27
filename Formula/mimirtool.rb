class Mimirtool < Formula
  desc "CLI for interacting with Grafana Mimir"
  homepage "https://example.org/mimirtool"
  version "mimir-3.2.3"
  url "http://127.0.0.1:8080/brew/bottles/mimirtool--mimir-3.2.3.loongarch64.bottle.tar.gz"
  sha256 "90aa66d8424092ccf34a314c0944938151a0ecefcf2a3985afb2aa1449a6ddeb"

  def install
    bin.install "mimirtool"
  end

  test do
    system "#{bin}/mimirtool"
  end
end
