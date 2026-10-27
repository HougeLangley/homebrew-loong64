class Cclimitping < Formula
  desc "Keep your Claude Code / Codex  5h rate-limit windows back-to-back — auto-pings each provid"
  homepage "https://example.org/cclimitping"
  version "1.3.1"
  url "http://127.0.0.1:8080/brew/bottles/cclimitping--1.3.1.loongarch64.bottle.tar.gz"
  sha256 "1c461656efea54acd48eda126ce337bb507d62fc1e0f7d26a96e92d88f08ad88"

  def install
    bin.install "cclimitping"
  end

  test do
    system "#{bin}/cclimitping"
  end
end
