class Lazy-tmux < Formula
  desc "Save all your tmux sessions and lazy restore them"
  homepage "https://example.org/lazy-tmux"
  version "0.3.1"
  url "http://127.0.0.1:8080/brew/bottles/lazy-tmux--0.3.1.loongarch64.bottle.tar.gz"
  sha256 "59f97d1c7ef8629feb8d57d9d1950cf46fa33fbcfec6cd8d3eae7ea83c45cb86"

  def install
    bin.install "lazy-tmux"
  end

  test do
    system "#{bin}/lazy-tmux"
  end
end
