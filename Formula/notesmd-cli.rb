class Notesmd-cli < Formula
  desc "Obsidian CLI (Community) -  Interact with Obsidian in the terminal!"
  homepage "https://example.org/notesmd-cli"
  version "0.3.8"
  url "http://127.0.0.1:8080/brew/bottles/notesmd-cli--0.3.8.loongarch64.bottle.tar.gz"
  sha256 "666a18ac55c236610009e066519313984387d1a8fcb425ffa639ace0e7177afc"

  def install
    bin.install "notesmd-cli"
  end

  test do
    system "#{bin}/notesmd-cli"
  end
end
