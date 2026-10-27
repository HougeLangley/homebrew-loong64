class Bubbletea < Formula
  desc "A powerful little TUI framework 🏗"
  homepage "https://example.org/bubbletea"
  version "2.1.0"
  url "http://127.0.0.1:8080/brew/bottles/bubbletea--2.1.0.loongarch64.bottle.tar.gz"
  sha256 "aef6af6889e01233b78249092194123b385c2c85f1f1b0509e612edc54cad211"

  def install
    bin.install "bubbletea"
  end

  test do
    system "#{bin}/bubbletea"
  end
end
