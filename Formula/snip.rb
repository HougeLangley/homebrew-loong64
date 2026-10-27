class Snip < Formula
  desc "CLI proxy that reduces LLM token usage by 60-90%. Declarative YAML filters for Claude Code"
  homepage "https://example.org/snip"
  version "0.25.2"
  url "http://127.0.0.1:8080/brew/bottles/snip--0.25.2.loongarch64.bottle.tar.gz"
  sha256 "255bbed66abafc8f598f3465108add1b1742ef056679be03e2f6378898401530"

  def install
    bin.install "snip"
  end

  test do
    system "#{bin}/snip"
  end
end
