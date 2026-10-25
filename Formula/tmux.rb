class Tmux < Formula
  desc "Terminal multiplexer"
  homepage "https://example.org/tmux"
  version "3.8"
  url "http://127.0.0.1:8080/brew/bottles/tmux--3.8.loongarch64.bottle.tar.gz"
  sha256 "f37ac724d7ae8a9e39d7b0cfa2487beb2a7b9662644f6f14bbc30c29f214fe11"

  def install
    bin.install "tmux"
  end

  test do
    system "#{bin}/tmux"
  end
end
