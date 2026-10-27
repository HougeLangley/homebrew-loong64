class Talosctl < Formula
  desc "CLI for out-of-band management of Kubernetes nodes created by Talos"
  homepage "https://example.org/talosctl"
  version "1.14.5"
  url "http://127.0.0.1:8080/brew/bottles/talosctl--1.14.5.loongarch64.bottle.tar.gz"
  sha256 "d52e2a1e4af6b59c50fa50dc9ed4e8876600e4ebcb92fb2f8291bdfc43999562"

  def install
    bin.install "talosctl"
  end

  test do
    system "#{bin}/talosctl"
  end
end
