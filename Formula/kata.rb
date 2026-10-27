class Kata < Formula
  desc "Local-first, federated issue tracker for humans and coding agents"
  homepage "https://example.org/kata"
  version "0.20.0"
  url "http://127.0.0.1:8080/brew/bottles/kata--0.20.0.loongarch64.bottle.tar.gz"
  sha256 "4bd97df63fe7df4a77aa76d124489dd5e7a8d8d97a00e2dc0dca5ea6afabcedb"

  def install
    bin.install "kata"
  end

  test do
    system "#{bin}/kata"
  end
end
