class Oj < Formula
  desc "JSON parser and visualization tool"
  homepage "https://example.org/oj"
  version "1.28.8"
  url "http://127.0.0.1:8080/brew/bottles/oj--1.28.8.loongarch64.bottle.tar.gz"
  sha256 "3c0e5ca59b90c672e57ef8c296df8cdd50309245f7ccd3e7e12a88c4fa19ee74"

  def install
    bin.install "oj"
  end

  test do
    system "#{bin}/oj"
  end
end
