class Prometheus-msteams < Formula
  desc "Forward Prometheus Alert Manager notifications to Microsoft Teams."
  homepage "https://example.org/prometheus-msteams"
  version "1.5.4"
  url "http://127.0.0.1:8080/brew/bottles/prometheus-msteams--1.5.4.loongarch64.bottle.tar.gz"
  sha256 "0c2e6ed072cd10be5a28dd11665f1c8c0d4becefc21e837e77ddc723b9282ea8"

  def install
    bin.install "prometheus-msteams"
  end

  test do
    system "#{bin}/prometheus-msteams"
  end
end
