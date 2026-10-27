class Gentleman < Formula
  desc "Plugin-driven, extensible HTTP client toolkit for Go"
  homepage "https://example.org/gentleman"
  version "2.0.5"
  url "http://127.0.0.1:8080/brew/bottles/gentleman--2.0.5.loongarch64.bottle.tar.gz"
  sha256 "bed976069c10b96b6420a19c8f63d3e66c45f761e3554da6e364fdd5ff61be77"

  def install
    bin.install "gentleman"
  end

  test do
    system "#{bin}/gentleman"
  end
end
