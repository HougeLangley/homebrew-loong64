class Postgresparser < Formula
  desc "ANTLR-based PostgreSQL query parser for Go. Extracts tables, columns, joins, CTEs, paramet"
  homepage "https://example.org/postgresparser"
  version "1.3.2"
  url "http://127.0.0.1:8080/brew/bottles/postgresparser--1.3.2.loongarch64.bottle.tar.gz"
  sha256 "ba5f679fa4f365710bf888828ff95302bffcf0cf5f1930fc56048be174409e9a"

  def install
    bin.install "postgresparser"
  end

  test do
    system "#{bin}/postgresparser"
  end
end
