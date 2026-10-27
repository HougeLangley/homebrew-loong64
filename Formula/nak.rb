class Nak < Formula
  desc "CLI for doing all things nostr"
  homepage "https://example.org/nak"
  version "0.21.2"
  url "http://127.0.0.1:8080/brew/bottles/nak--0.21.2.loongarch64.bottle.tar.gz"
  sha256 "66eba64e5faf1ffd0081606bd3953d53e1c428d92a1a37f93d46cbf5c1a809ec"

  def install
    bin.install "nak"
  end

  test do
    system "#{bin}/nak"
  end
end
