class Sqlite < Formula
  desc "Command-line interface for SQLite"
  homepage "https://example.org/sqlite"
  version "3.54.1"
  url "http://127.0.0.1:8080/brew/bottles/sqlite--3.54.1.loongarch64.bottle.tar.gz"
  sha256 "23101a77dfb2042e5adaba1cdee4542436420b7d77aacfa93efd725697d27586"

  def install
    bin.install "sqlite3"
  end

  test do
    system "#{bin}/sqlite"
  end
end
