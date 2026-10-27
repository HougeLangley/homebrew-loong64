class Tabctl < Formula
  desc "Command-line tool to list, switch, close, and open tabs across Firefox, Chrome, and other "
  homepage "https://example.org/tabctl"
  version "2.3.1"
  url "http://127.0.0.1:8080/brew/bottles/tabctl--2.3.1.loongarch64.bottle.tar.gz"
  sha256 "a9bdfcd3783a3399f4819bcdddc8dff4e07ec2cec13008b89f9cba11682e9b63"

  def install
    bin.install "tabctl"
  end

  test do
    system "#{bin}/tabctl"
  end
end
