class Zellij < Formula
  desc "Terminal workspace"
  homepage "https://example.org/zellij"
  version "0.45.1"
  url "http://127.0.0.1:8080/brew/bottles/zellij--0.45.1.loongarch64.bottle.tar.gz"
  sha256 "96aab71d024b5cb40b62d06e4ba4232fcfd998d83863927de3361abada3a083d"

  def install
    bin.install "zellij"
  end

  test do
    system "#{bin}/zellij"
  end
end
