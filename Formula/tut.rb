class Tut < Formula
  desc "TUI for Mastodon with vim inspired keys"
  homepage "https://example.org/tut"
  version "2.0.1"
  url "http://127.0.0.1:8080/brew/bottles/tut--2.0.1.loongarch64.bottle.tar.gz"
  sha256 "5e1fe37afe98dd2f0041c099bf5ff89534a610ff5bb8c06b649f50267831ba5d"

  def install
    bin.install "tut"
  end

  test do
    system "#{bin}/tut"
  end
end
