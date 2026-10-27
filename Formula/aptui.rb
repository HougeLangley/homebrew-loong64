class Aptui < Formula
  desc "TUI package manager for APT-based Linux distributions"
  homepage "https://example.org/aptui"
  version "0.8.2"
  url "http://127.0.0.1:8080/brew/bottles/aptui--0.8.2.loongarch64.bottle.tar.gz"
  sha256 "237a963c848b391e383f610699dd9e6bafdcb8938d7cb35f8b4a865bdf1e542b"

  def install
    bin.install "aptui"
  end

  test do
    system "#{bin}/aptui"
  end
end
