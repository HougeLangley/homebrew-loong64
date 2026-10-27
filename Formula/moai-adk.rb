class Moai-adk < Formula
  desc "Agentic development harness for Claude Code — SPEC-driven plan/run/sync, TRUST 5 quality g"
  homepage "https://example.org/moai-adk"
  version "3.1.2"
  url "http://127.0.0.1:8080/brew/bottles/moai-adk--3.1.2.loongarch64.bottle.tar.gz"
  sha256 "3a3dd0e18ce0c0f1ea5c45ce5ec6b56e3150d4c3ba279d2b113aa2fb758b2c65"

  def install
    bin.install "moai-adk"
  end

  test do
    system "#{bin}/moai-adk"
  end
end
