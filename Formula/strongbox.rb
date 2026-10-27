class Strongbox < Formula
  desc "Encryption for Git users"
  homepage "https://example.org/strongbox"
  version "2.1.0"
  url "http://127.0.0.1:8080/brew/bottles/strongbox--2.1.0.loongarch64.bottle.tar.gz"
  sha256 "d727bf2ba3a002c5ed5e0499c7b739a772d368cf93d2e52f40c955a0b0be68f9"

  def install
    bin.install "strongbox"
  end

  test do
    system "#{bin}/strongbox"
  end
end
