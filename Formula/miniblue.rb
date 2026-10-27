class Miniblue < Formula
  desc "Local Azure development. One binary. No account needed. 25+ emulated services for testing,"
  homepage "https://example.org/miniblue"
  version "0.8.0"
  url "http://127.0.0.1:8080/brew/bottles/miniblue--0.8.0.loongarch64.bottle.tar.gz"
  sha256 "7dc74e79e48b20eda0d8ea46623aa9da58ff37e65229043a988c255c200536ea"

  def install
    bin.install "miniblue"
  end

  test do
    system "#{bin}/miniblue"
  end
end
