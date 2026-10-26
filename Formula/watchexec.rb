class Watchexec < Formula
  desc "Executes commands when files change"
  homepage "https://example.org/watchexec"
  version "2.8.0"
  url "http://127.0.0.1:8080/brew/bottles/watchexec--2.8.0.loongarch64.bottle.tar.gz"
  sha256 "9a4a5aff036674473956338eb70c809b024d6bd55a7395cc4745314b6ca39613"

  def install
    bin.install "watchexec"
  end

  test do
    system "#{bin}/watchexec"
  end
end
