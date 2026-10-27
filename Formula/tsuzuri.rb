class Tsuzuri < Formula
  desc " Block-based notebook for the terminal. Plain Markdown files, Vim editing, live preview, b"
  homepage "https://example.org/tsuzuri"
  version "0.3.1"
  url "http://127.0.0.1:8080/brew/bottles/tsuzuri--0.3.1.loongarch64.bottle.tar.gz"
  sha256 "8feb6150b6bd7fe04040cb97d11befbd47f47d108537da4c338e16317188b572"

  def install
    bin.install "tsuzuri"
  end

  test do
    system "#{bin}/tsuzuri"
  end
end
