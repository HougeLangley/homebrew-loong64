class Jjui < Formula
  desc "TUI for interacting with the Jujutsu version control system"
  homepage "https://example.org/jjui"
  version "0.10.12"
  url "http://127.0.0.1:8080/brew/bottles/jjui--0.10.12.loongarch64.bottle.tar.gz"
  sha256 "d7b0c285530faaf59a1474d89724e570cec5516de1d5bf32bb5fa6abee193bf6"

  def install
    bin.install "jjui"
  end

  test do
    system "#{bin}/jjui"
  end
end
