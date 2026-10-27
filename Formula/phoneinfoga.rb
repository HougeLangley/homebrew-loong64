class Phoneinfoga < Formula
  desc "Information gathering framework for phone numbers"
  homepage "https://example.org/phoneinfoga"
  version "2.11.0"
  url "http://127.0.0.1:8080/brew/bottles/phoneinfoga--2.11.0.loongarch64.bottle.tar.gz"
  sha256 "1b9594e9c3f070e30c47d01b4386b25323449aa6e12d35f891ed0908f5c77639"

  def install
    bin.install "phoneinfoga"
  end

  test do
    system "#{bin}/phoneinfoga"
  end
end
