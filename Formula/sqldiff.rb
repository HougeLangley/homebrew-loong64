class Sqldiff < Formula
  desc "Displays the differences between SQLite databases"
  homepage "https://www.sqlite.org/sqldiff.html"
  url "https://www.sqlite.org/2026/sqlite-src-3540100.zip"
  version "3.54.1"
  sha256 "387e7f6cad4797b17848c07d453dc6606917bb356a6cfe5a3abafd38c240c71b"
  license "blessing"

  livecheck do
    formula "sqlite"
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d5207494a9fdf5efebbafa1f74ed310764acabde7b0ab1cbfae5f1bbae530f4b"
  end

  uses_from_macos "tcl-tk" => :build
  uses_from_macos "sqlite" => :test


  def install
    system "./configure", "--disable-debug", "--prefix=#{prefix}"
    system "make", "sqldiff"
    bin.install "sqldiff"
  end

  test do
    dbpath = testpath/"test.sqlite"
    sqlpath = testpath/"test.sql"
    sqlpath.write "create table test (name text);"
    system "sqlite3 #{dbpath} < #{sqlpath}"
    assert_equal "test: 0 changes, 0 inserts, 0 deletes, 0 unchanged",
                 shell_output("#{bin}/sqldiff --summary #{dbpath} #{dbpath}").strip
  end
end
