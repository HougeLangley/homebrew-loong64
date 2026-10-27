class Httpretty < Formula
  desc "Package httpretty prints the HTTP requests you make with Go pretty on your terminal."
  homepage "https://example.org/httpretty"
  version "0.2.0"
  url "http://127.0.0.1:8080/brew/bottles/httpretty--0.2.0.loongarch64.bottle.tar.gz"
  sha256 "0a1325cee1bc0089705c0b5798add8fc9a73b8085a3b0ec359c79fea42b438ee"

  def install
    bin.install "httpretty"
  end

  test do
    system "#{bin}/httpretty"
  end
end
