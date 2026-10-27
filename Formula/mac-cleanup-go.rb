class Mac-cleanup-go < Formula
  desc "TUI macOS cleaner that scans caches/logs and lets you select what to delete"
  homepage "https://example.org/mac-cleanup-go"
  version "1.6.0"
  url "http://127.0.0.1:8080/brew/bottles/mac-cleanup-go--1.6.0.loongarch64.bottle.tar.gz"
  sha256 "6329f301dc3a5df0c15079141bc76e28a4e4f3d355633cb6dc0543de44495b78"

  def install
    bin.install "mac-cleanup-go"
  end

  test do
    system "#{bin}/mac-cleanup-go"
  end
end
