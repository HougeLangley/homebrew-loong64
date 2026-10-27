class Ctx-wire < Formula
  desc "ctx-wire runs your commands, compresses the output with declarative filters, scrubs secret"
  homepage "https://example.org/ctx-wire"
  version "0.1.74"
  url "http://127.0.0.1:8080/brew/bottles/ctx-wire--0.1.74.loongarch64.bottle.tar.gz"
  sha256 "48a15720109f30854d516af65657f79b367b7a79ba30203b05054dd9b806b958"

  def install
    bin.install "ctx-wire"
  end

  test do
    system "#{bin}/ctx-wire"
  end
end
