class Promtail < Formula
  desc "Log agent for Loki"
  homepage "https://example.org/promtail"
  version "3.7.9"
  url "http://127.0.0.1:8080/brew/bottles/promtail--3.7.9.loongarch64.bottle.tar.gz"
  sha256 "96ea94f6078d9217387b6b07c6e77af26ecd67e8c38e398c7ec46af3aa1f2b36"

  def install
    bin.install "promtail"
  end

  test do
    system "#{bin}/promtail"
  end
end
