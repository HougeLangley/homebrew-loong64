class Recur < Formula
  desc "Retry a command with exponential backoff and jitter"
  homepage "https://example.org/recur"
  version "3.3.0"
  url "http://127.0.0.1:8080/brew/bottles/recur--3.3.0.loongarch64.bottle.tar.gz"
  sha256 "86a0bebb5ea80c86fefef9388d4c6be8812d9a8830f6e030db5ba33808bb5da4"

  def install
    bin.install "recur"
  end

  test do
    system "#{bin}/recur"
  end
end
