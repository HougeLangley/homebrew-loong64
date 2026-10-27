class Clickhouse-sql-parser < Formula
  desc "Writing clickhouse sql parser in pure Go"
  homepage "https://example.org/clickhouse-sql-parser"
  version "0.5.6"
  url "http://127.0.0.1:8080/brew/bottles/clickhouse-sql-parser--0.5.6.loongarch64.bottle.tar.gz"
  sha256 "a83c59a3a8180d0d5edd8e85eef9e63bd1484ba9b13bca12fe8db98f3130afb1"

  def install
    bin.install "clickhouse-sql-parser"
  end

  test do
    system "#{bin}/clickhouse-sql-parser"
  end
end
