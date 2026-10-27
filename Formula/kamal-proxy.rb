class Kamal-proxy < Formula
  desc "Lightweight proxy server for Kamal"
  homepage "https://example.org/kamal-proxy"
  version "0.10.2"
  url "http://127.0.0.1:8080/brew/bottles/kamal-proxy--0.10.2.loongarch64.bottle.tar.gz"
  sha256 "18901266678bf518909029fd2466c5643184086b35dc0cf14ca3b24baef0fb2d"

  def install
    bin.install "kamal-proxy"
  end

  test do
    system "#{bin}/kamal-proxy"
  end
end
