class Golazo < Formula
  desc "The beautiful game in your terminal. Minimal TUI app to keep up with live & recent footbal"
  homepage "https://example.org/golazo"
  version "0.33.0"
  url "http://127.0.0.1:8080/brew/bottles/golazo--0.33.0.loongarch64.bottle.tar.gz"
  sha256 "82a5e9de0677150b43209f8f359bf3399fd4f82ee1c72c3dd6b2aa9e3c7d45fa"

  def install
    bin.install "golazo"
  end

  test do
    system "#{bin}/golazo"
  end
end
