class Trojan-go < Formula
  desc "Trojan proxy in Go"
  homepage "https://example.org/trojan-go"
  version "0.10.6"
  url "http://127.0.0.1:8080/brew/bottles/trojan-go--0.10.6.loongarch64.bottle.tar.gz"
  sha256 "820e5a89881a7ed4473aabbcff59e43fc8dbc49f1e6feb3cbe1791593911827b"

  def install
    bin.install "trojan-go"
  end

  test do
    system "#{bin}/trojan-go"
  end
end
