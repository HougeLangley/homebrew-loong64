class Fsql < Formula
  desc "Search through your filesystem with SQL-esque queries"
  homepage "https://example.org/fsql"
  version "0.5.2"
  url "http://127.0.0.1:8080/brew/bottles/fsql--0.5.2.loongarch64.bottle.tar.gz"
  sha256 "9d39531961f89edce9cdc694cd27bf78af45c006939ebde23e8a0bcd45981cd9"

  def install
    bin.install "fsql"
  end

  test do
    system "#{bin}/fsql"
  end
end
