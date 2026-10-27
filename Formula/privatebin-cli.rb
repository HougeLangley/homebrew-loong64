class Privatebin-cli < Formula
  desc "CLI for creating and managing PrivateBin pastes"
  homepage "https://example.org/privatebin-cli"
  version "2.2.1"
  url "http://127.0.0.1:8080/brew/bottles/privatebin-cli--2.2.1.loongarch64.bottle.tar.gz"
  sha256 "584454940f60a703919fa4e43a0dbbc19399ee7b46ec3903f25bf4e061271d5c"

  def install
    bin.install "privatebin-cli"
  end

  test do
    system "#{bin}/privatebin-cli"
  end
end
