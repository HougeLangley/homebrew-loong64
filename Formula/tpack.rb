class Tpack < Formula
  desc "Drop-in replacement for tmux-plugin-manager (tpm) with a TUI"
  homepage "https://example.org/tpack"
  version "2.0.7"
  url "http://127.0.0.1:8080/brew/bottles/tpack--2.0.7.loongarch64.bottle.tar.gz"
  sha256 "d1be68dfd4382c0ef3f21eb85fc71edb6c4664a3b89d5331a9387dcff11c46f5"

  def install
    bin.install "tpack"
  end

  test do
    system "#{bin}/tpack"
  end
end
