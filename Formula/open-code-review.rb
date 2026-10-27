class Open-code-review < Formula
  desc "AI-powered code review tool with deterministic pipelines and an LLM agent"
  homepage "https://example.org/open-code-review"
  version "1.13.3"
  url "http://127.0.0.1:8080/brew/bottles/open-code-review--1.13.3.loongarch64.bottle.tar.gz"
  sha256 "39c198fe529fcabb9db86cfe9f40b7c0c5e63c687ad0b481c3c3b089c1c458d4"

  def install
    bin.install "open-code-review"
  end

  test do
    system "#{bin}/open-code-review"
  end
end
