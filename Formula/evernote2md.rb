class Evernote2md < Formula
  desc "Convert Evernote .enex file to Markdown"
  homepage "https://example.org/evernote2md"
  version "0.23.0"
  url "http://127.0.0.1:8080/brew/bottles/evernote2md--0.23.0.loongarch64.bottle.tar.gz"
  sha256 "0ab9f1540b107107619842dfd44d8f2de9cf848f55d0ff5e562a6ee5a32868ab"

  def install
    bin.install "evernote2md"
  end

  test do
    system "#{bin}/evernote2md"
  end
end
