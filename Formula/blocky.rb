class Blocky < Formula
  desc "Fast and lightweight DNS proxy as ad-blocker for local network"
  homepage "https://example.org/blocky"
  version "0.35.0"
  url "http://127.0.0.1:8080/brew/bottles/blocky--0.35.0.loongarch64.bottle.tar.gz"
  sha256 "7061b4b306541b668eed5c5b70b3076aaa38710ad01541f345da69db10926a7f"

  def install
    bin.install "blocky"
  end

  test do
    system "#{bin}/blocky"
  end
end
