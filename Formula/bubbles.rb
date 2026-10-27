class Bubbles < Formula
  desc "TUI components for Bubble Tea 🫧"
  homepage "https://example.org/bubbles"
  version "2.2.1"
  url "http://127.0.0.1:8080/brew/bottles/bubbles--2.2.1.loongarch64.bottle.tar.gz"
  sha256 "fc8ebb86e4e7ef0074d9f4cd0380d827fc55c803a84a304e7fc3bce584b85ff2"

  def install
    bin.install "bubbles"
  end

  test do
    system "#{bin}/bubbles"
  end
end
