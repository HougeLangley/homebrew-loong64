class Comanda < Formula
  desc "The CLI-native orchestrator for AI agent workflows. Run Claude Code, Codex, Gemini CLI & K"
  homepage "https://example.org/comanda"
  version "0.0.254"
  url "http://127.0.0.1:8080/brew/bottles/comanda--0.0.254.loongarch64.bottle.tar.gz"
  sha256 "a4ae240ccb473c3176422e9e019fa0c2cbc789bc1ed1d52c5f6117470c8e59b7"

  def install
    bin.install "comanda"
  end

  test do
    system "#{bin}/comanda"
  end
end
