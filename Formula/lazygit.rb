class Lazygit < Formula
  desc "Simple terminal UI for git commands"
  homepage "https://example.org/lazygit"
  version "0.66.2"
  url "http://127.0.0.1:8080/brew/bottles/lazygit--0.66.2.loongarch64.bottle.tar.gz"
  sha256 "74f1655fbf76ebf5fbe96af92af5e4a4a6ac9a9008a1b8c93aebfa50ed0cf254"

  def install
    bin.install "lazygit"
  end

  test do
    system "#{bin}/lazygit"
  end
end
