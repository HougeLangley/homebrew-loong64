class Neovim < Formula
  desc "Vim-fork focused on extensibility and usability"
  homepage "https://example.org/neovim"
  version "0.12.6"
  url "http://127.0.0.1:8080/brew/bottles/neovim--0.12.6.loongarch64.bottle.tar.gz"
  sha256 "8e7a897db179adb5060bee75b4f650946065d3de8518c58dde037d310c6d267f"

  def install
    bin.install "neovim"
  end

  test do
    system "#{bin}/neovim"
  end
end
