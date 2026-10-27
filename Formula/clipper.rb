class Clipper < Formula
  desc "Share macOS clipboard with tmux and other local and remote apps"
  homepage "https://example.org/clipper"
  version "3.0.0"
  url "http://127.0.0.1:8080/brew/bottles/clipper--3.0.0.loongarch64.bottle.tar.gz"
  sha256 "0ad584861368452c96a5f7c6923197233d183c18e411b772ba07997fc6b66783"

  def install
    bin.install "clipper"
  end

  test do
    system "#{bin}/clipper"
  end
end
