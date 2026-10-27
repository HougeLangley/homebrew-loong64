class Grafanactl < Formula
  desc "CLI to interact with Grafana"
  homepage "https://example.org/grafanactl"
  version "0.1.10"
  url "http://127.0.0.1:8080/brew/bottles/grafanactl--0.1.10.loongarch64.bottle.tar.gz"
  sha256 "2ed513f12d5946d3eab83345e9e26b921d995de5a60df0e0e74feda09d0073ba"

  def install
    bin.install "grafanactl"
  end

  test do
    system "#{bin}/grafanactl"
  end
end
