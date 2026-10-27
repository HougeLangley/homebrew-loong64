class Metricbeat < Formula
  desc "Collect metrics from your systems and services"
  homepage "https://example.org/metricbeat"
  version "9.5.5"
  url "http://127.0.0.1:8080/brew/bottles/metricbeat--9.5.5.loongarch64.bottle.tar.gz"
  sha256 "d9439b8204b672430d5bbc8e3cd662e034a5d81406346f8f922caa577680db8d"

  def install
    bin.install "metricbeat"
  end

  test do
    system "#{bin}/metricbeat"
  end
end
