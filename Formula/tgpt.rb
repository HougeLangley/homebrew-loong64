class Tgpt < Formula
  desc "AI Chatbots in terminal for free"
  homepage "https://example.org/tgpt"
  version "2.15.0"
  url "http://127.0.0.1:8080/brew/bottles/tgpt--2.15.0.loongarch64.bottle.tar.gz"
  sha256 "6b4b58f35b4d3f03bbdf6033ad62fd6dd62d3322d79a8c946c6cff02083d2f97"

  def install
    bin.install "tgpt"
  end

  test do
    system "#{bin}/tgpt"
  end
end
