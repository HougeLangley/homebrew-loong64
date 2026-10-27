class Tcpterm < Formula
  desc "tcpterm is a packet visualizer in TUI."
  homepage "https://example.org/tcpterm"
  version "0.0.2"
  url "http://127.0.0.1:8080/brew/bottles/tcpterm--0.0.2.loongarch64.bottle.tar.gz"
  sha256 "7332bdd5c8549491b8fdda764749d6ce8bb187fb4a6fd20e4d0f3ce6b7db316d"

  def install
    bin.install "tcpterm"
  end

  test do
    system "#{bin}/tcpterm"
  end
end
