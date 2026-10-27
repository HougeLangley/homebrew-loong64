class Jabba < Formula
  desc "Cross-platform Java Version Manager"
  homepage "https://example.org/jabba"
  version "0.15.0"
  url "http://127.0.0.1:8080/brew/bottles/jabba--0.15.0.loongarch64.bottle.tar.gz"
  sha256 "273c52dacdb0ab2d7f3a31e6965b66ca690536f93dbfcead3e681c19f6ee4afa"

  def install
    bin.install "jabba"
  end

  test do
    system "#{bin}/jabba"
  end
end
