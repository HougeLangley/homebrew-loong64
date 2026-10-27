class Laitos < Formula
  desc "Top geek's chindogu - personal assistant over satellite/telephone/SMS/chatbot, plus web in"
  homepage "https://example.org/laitos"
  version "8.0"
  url "http://127.0.0.1:8080/brew/bottles/laitos--8.0.loongarch64.bottle.tar.gz"
  sha256 "a6a08ccb09156f62b71f537221e92184c505c7446c2fa829e44908af765a30b8"

  def install
    bin.install "laitos"
  end

  test do
    system "#{bin}/laitos"
  end
end
