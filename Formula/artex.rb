class Artex < Formula
  desc "ARTEX · AI autonomous penetration testing system (multi-agent LLM, Go + Next.js) · AI 自主渗透"
  homepage "https://example.org/artex"
  version "0.3.15"
  url "http://127.0.0.1:8080/brew/bottles/artex--0.3.15.loongarch64.bottle.tar.gz"
  sha256 "72124fabf9c6d2b5c83d8b837dc9d2655afa95d44a98a6d2b02740883cd4a851"

  def install
    bin.install "artex"
  end

  test do
    system "#{bin}/artex"
  end
end
