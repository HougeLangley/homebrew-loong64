class Gtree < Formula
  desc "Generate directory trees and directories using Markdown or programmatically"
  homepage "https://example.org/gtree"
  version "1.14.9"
  url "http://127.0.0.1:8080/brew/bottles/gtree--1.14.9.loongarch64.bottle.tar.gz"
  sha256 "fc282c18a77f8ca65798070384f0613648ad58b4cd3f8475ffe7ce68c10de921"

  def install
    bin.install "gtree"
  end

  test do
    system "#{bin}/gtree"
  end
end
