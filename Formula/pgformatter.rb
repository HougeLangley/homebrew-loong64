class Pgformatter < Formula
  desc "PostgreSQL syntax beautifier"
  homepage "https://sqlformat.darold.net/"
  url "https://github.com/darold/pgFormatter/archive/refs/tags/v5.11.tar.gz"
  sha256 "563619e13294b3db55d7a98a761786024ea3609d007fa94654a69a7346b8fd67"
  license "PostgreSQL"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "b280ef8e18f00e14898812c3659a1b0d035c727baf0281dbea47c43ded7c3a1a"
  end

  def install
    system "perl", "Makefile.PL", "DESTDIR=.", "MAN1EXT=1"
    system "make", "install"

    if OS.linux?
      # This Perl installs under usr/{bin,share}, not usr/local. Install the
      # observed man pages directly instead of renaming a nonexistent directory.
      share.install "usr/share/man"
    else
      prefix.install (buildpath/"usr/local").children
    end

    (libexec/"lib").install "blib/lib/pgFormatter"
    if OS.linux?
      libexec.install buildpath/"usr/bin/site_perl/pg_format"
    else
      libexec.install bin/"pg_format"
    end
    bin.install_symlink libexec/"pg_format"

    # Build an `:all` bottle
    rm_r share/"perl" if OS.linux? && (share/"perl").exist?
    chmod 0755, [bin, share, share/"man", man1, man3] # permissions match
  end

  test do
    test_file = (testpath/"test.sql")
    test_file.write("SELECT * FROM foo")
    system bin/"pg_format", test_file
  end
end
