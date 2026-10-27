class Dbmate < Formula
  desc "🚀 A lightweight, framework-agnostic database migration tool."
  homepage "https://example.org/dbmate"
  version "2.37.0"
  url "http://127.0.0.1:8080/brew/bottles/dbmate--2.37.0.loongarch64.bottle.tar.gz"
  sha256 "958b08c270b774bd1da99cf5bf4989631075ed56deee8c1bbc9835e04701ea02"

  def install
    bin.install "dbmate"
  end

  test do
    system "#{bin}/dbmate"
  end
end
