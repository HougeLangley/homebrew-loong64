class Grizzly < Formula
  desc "Command-line tool for managing and automating Grafana dashboards"
  homepage "https://example.org/grizzly"
  version "0.7.1"
  url "http://127.0.0.1:8080/brew/bottles/grizzly--0.7.1.loongarch64.bottle.tar.gz"
  sha256 "f24100d492332716e1e1d1eafc91014a5d832b02977f9835593523c34996ad34"

  def install
    bin.install "grizzly"
  end

  test do
    system "#{bin}/grizzly"
  end
end
