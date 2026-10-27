class Gomplate < Formula
  desc "A flexible commandline tool for template rendering. Supports lots of local and remote data"
  homepage "https://example.org/gomplate"
  version "5.3.1"
  url "http://127.0.0.1:8080/brew/bottles/gomplate--5.3.1.loongarch64.bottle.tar.gz"
  sha256 "85b7d40608b1370411c8c1e1e3166f5e5dcc5fb483cf123c29e9ce63cdfff32a"

  def install
    bin.install "gomplate"
  end

  test do
    system "#{bin}/gomplate"
  end
end
