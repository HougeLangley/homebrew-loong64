class Grafterm < Formula
  desc "Metrics dashboards on terminal (a grafana inspired terminal version)"
  homepage "https://example.org/grafterm"
  version "0.2.0"
  url "http://127.0.0.1:8080/brew/bottles/grafterm--0.2.0.loongarch64.bottle.tar.gz"
  sha256 "a3b3f79e7737c60af6b686b2ef401831518e81b5b8111549044b2d590b4e5f8b"

  def install
    bin.install "grafterm"
  end

  test do
    system "#{bin}/grafterm"
  end
end
