class Gitdb < Formula
  desc "Distributed Embeddable Database"
  homepage "https://example.org/gitdb"
  version "1.0.1"
  url "http://127.0.0.1:8080/brew/bottles/gitdb--1.0.1.loongarch64.bottle.tar.gz"
  sha256 "61ce9d38eef47cdca21680c75c009ccd3dcf3a4bb5530349a33fcb95b99eb512"

  def install
    bin.install "gitdb"
  end

  test do
    system "#{bin}/gitdb"
  end
end
