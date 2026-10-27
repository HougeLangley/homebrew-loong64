class Euterpe < Formula
  desc "Self-hosted music streaming server 🎶 with RESTful API and Web interface. Think of it as yo"
  homepage "https://example.org/euterpe"
  version "1.6.3"
  url "http://127.0.0.1:8080/brew/bottles/euterpe--1.6.3.loongarch64.bottle.tar.gz"
  sha256 "b297b30b70cd1445197065ecfcd491ecff258e2a897e62fd8d67582073f677c3"

  def install
    bin.install "euterpe"
  end

  test do
    system "#{bin}/euterpe"
  end
end
