class Gitmux < Formula
  desc ":computer: Git in your tmux status bar"
  homepage "https://example.org/gitmux"
  version "0.11.5"
  url "http://127.0.0.1:8080/brew/bottles/gitmux--0.11.5.loongarch64.bottle.tar.gz"
  sha256 "f9c625d4e47289886be3709721c77b4082628f1373671694c194cbd6ab12c2ae"

  def install
    bin.install "gitmux"
  end

  test do
    system "#{bin}/gitmux"
  end
end
