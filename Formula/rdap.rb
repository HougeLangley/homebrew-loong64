class Rdap < Formula
  desc "Command-line client for the Registration Data Access Protocol"
  homepage "https://example.org/rdap"
  version "0.10.2"
  url "http://127.0.0.1:8080/brew/bottles/rdap--0.10.2.loongarch64.bottle.tar.gz"
  sha256 "1ad291a3e1df248b69ce4a19bda80cf5ae09d71f7383d64b5a80a165846ae925"

  def install
    bin.install "rdap"
  end

  test do
    system "#{bin}/rdap"
  end
end
