class Jid < Formula
  desc "json incremental digger"
  homepage "https://example.org/jid"
  version "1.1.3"
  url "http://127.0.0.1:8080/brew/bottles/jid--1.1.3.loongarch64.bottle.tar.gz"
  sha256 "07601583cb308254d8b2799c46e0f7a876a27d515b95d5da6c12c125d014bd87"

  def install
    bin.install "jid"
  end

  test do
    system "#{bin}/jid"
  end
end
