class Gpt-project-context < Formula
  desc "Easily provide project context to ChatGPT and boost your productivity with this CLI tool! "
  homepage "https://example.org/gpt-project-context"
  version "1.1.3"
  url "http://127.0.0.1:8080/brew/bottles/gpt-project-context--1.1.3.loongarch64.bottle.tar.gz"
  sha256 "3c9e2a44c28f5b685d79c6732a5a5404b314b4dd579f50c523dff360ad6df06e"

  def install
    bin.install "gpt-project-context"
  end

  test do
    system "#{bin}/gpt-project-context"
  end
end
