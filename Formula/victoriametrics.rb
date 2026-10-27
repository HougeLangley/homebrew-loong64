class Victoriametrics < Formula
  desc "VictoriaMetrics: fast, cost-effective monitoring solution and time series database"
  homepage "https://example.org/victoriametrics"
  version "1.155.0"
  url "http://127.0.0.1:8080/brew/bottles/victoriametrics--1.155.0.loongarch64.bottle.tar.gz"
  sha256 "64e6269672e2b9402c7c483ed3017fb6170c928fdbbc2ae5f4184ab4e5fca2c7"

  def install
    bin.install "victoriametrics"
  end

  test do
    system "#{bin}/victoriametrics"
  end
end
