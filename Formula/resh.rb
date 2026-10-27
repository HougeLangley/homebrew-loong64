class Resh < Formula
  desc "RESH ❯❯ Contextual shell history for zsh and bash"
  homepage "https://example.org/resh"
  version "3.0.2"
  url "http://127.0.0.1:8080/brew/bottles/resh--3.0.2.loongarch64.bottle.tar.gz"
  sha256 "7746a4727911c5f77ac4f3dd219085940ace945c906ad7740045f9d8ff193e25"

  def install
    bin.install "resh"
  end

  test do
    system "#{bin}/resh"
  end
end
