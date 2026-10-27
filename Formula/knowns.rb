class Knowns < Formula
  desc "Tasks, docs, specs and decisions for AI coding agents, as markdown in your repo. Keeps the"
  homepage "https://example.org/knowns"
  version "0.34.1"
  url "http://127.0.0.1:8080/brew/bottles/knowns--0.34.1.loongarch64.bottle.tar.gz"
  sha256 "70110eccf60dfd35d91389a3b00200214d17a1e9e04b999487bb64cedeb06a6b"

  def install
    bin.install "knowns"
  end

  test do
    system "#{bin}/knowns"
  end
end
