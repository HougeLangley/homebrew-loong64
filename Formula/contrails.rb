class Contrails < Formula
  desc "Desktop app that automatically captures your AI coding agent sessions (Claude Code, OpenCo"
  homepage "https://example.org/contrails"
  version "0.7.1"
  url "http://127.0.0.1:8080/brew/bottles/contrails--0.7.1.loongarch64.bottle.tar.gz"
  sha256 "d43ebd870d5d7e05fc9f5273c9b0ab90631661fdd233cebffddb3e43cf30ad58"

  def install
    bin.install "contrails"
  end

  test do
    system "#{bin}/contrails"
  end
end
