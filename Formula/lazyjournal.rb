class Lazyjournal < Formula
  desc "TUI for logs from journalctl, file system, Docker, Podman and Kubernetes pods"
  homepage "https://example.org/lazyjournal"
  version "0.8.6"
  url "http://127.0.0.1:8080/brew/bottles/lazyjournal--0.8.6.loongarch64.bottle.tar.gz"
  sha256 "207c0cad34f17de8a8a6435530a3f7cd2400f4b4a5a87e0e5cc5a59be1a18ad3"

  def install
    bin.install "lazyjournal"
  end

  test do
    system "#{bin}/lazyjournal"
  end
end
