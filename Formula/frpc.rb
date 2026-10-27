class Frpc < Formula
  desc "Client app of fast reverse proxy to expose a local server to the internet"
  homepage "https://example.org/frpc"
  version "0.71.1"
  url "http://127.0.0.1:8080/brew/bottles/frpc--0.71.1.loongarch64.bottle.tar.gz"
  sha256 "28cfd5723f90af801520a7df19f8150c00a49c575852955041bb6a9cee34f5a6"

  def install
    bin.install "frpc"
  end

  test do
    system "#{bin}/frpc"
  end
end
