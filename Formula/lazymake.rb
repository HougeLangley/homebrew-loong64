class Lazymake < Formula
  desc "Modern TUI for Makefiles"
  homepage "https://example.org/lazymake"
  version "0.4.1"
  url "http://127.0.0.1:8080/brew/bottles/lazymake--0.4.1.loongarch64.bottle.tar.gz"
  sha256 "eb94f75def6ed47eaf0280814ba65c2c33c9e736135d8bd47737ff3c81afbfe9"

  def install
    bin.install "lazymake"
  end

  test do
    system "#{bin}/lazymake"
  end
end
