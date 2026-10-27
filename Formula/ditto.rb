class Ditto < Formula
  desc "a system-wide ascii keyboard visualizer and keycaster in the terminal"
  homepage "https://example.org/ditto"
  version "1.3.3"
  url "http://127.0.0.1:8080/brew/bottles/ditto--1.3.3.loongarch64.bottle.tar.gz"
  sha256 "9730b376598d7823009387052849dada2362b1f48a723759a2a1500538ce836e"

  def install
    bin.install "ditto"
  end

  test do
    system "#{bin}/ditto"
  end
end
