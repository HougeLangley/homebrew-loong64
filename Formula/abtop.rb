class Abtop < Formula
  desc "Like htop, but for AI coding agents. Monitor Claude    Code & Codex CLI sessions, tokens, "
  homepage "https://example.org/abtop"
  version "0.5.5"
  url "http://127.0.0.1:8080/brew/bottles/abtop--0.5.5.loongarch64.bottle.tar.gz"
  sha256 "ef7bcbaf53c403f1a9110233ec99d0f520a8eb765aca38981803af59dffa3514"

  def install
    bin.install "abtop"
  end

  test do
    system "#{bin}/abtop"
  end
end
