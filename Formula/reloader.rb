class Reloader < Formula
  desc "A Kubernetes controller to watch changes in ConfigMap and Secrets and do rolling upgrades "
  homepage "https://example.org/reloader"
  version "chart-v2.2.18"
  url "http://127.0.0.1:8080/brew/bottles/reloader--chart-v2.2.18.loongarch64.bottle.tar.gz"
  sha256 "2e5956721139c1967401195fa1225ae54500f5109044d6448d32b2618268cec9"

  def install
    bin.install "reloader"
  end

  test do
    system "#{bin}/reloader"
  end
end
