class Pgcopydb < Formula
  desc "Copy a Postgres database to a target Postgres server"
  homepage "https://github.com/dimitri/pgcopydb"
  url "https://github.com/dimitri/pgcopydb/archive/refs/tags/v0.18.tar.gz"
  sha256 "d1fbc729b3d6aabbebd64f515a956130adf42a0e9104886084d76d5702fb99d0"
  license "PostgreSQL"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9d351c118dd164b58eb1612eb416d43a0bcf11cf61c9e87f8e01a50ac296f3bc"
  end

  head "https://github.com/dimitri/pgcopydb.git", branch: "main"



  depends_on "sphinx-doc" => :build
  depends_on "bdw-gc"
  depends_on "libpq"

  def install
    system "make", "bin"
    libexec.install "src/bin/pgcopydb/pgcopydb"

    (bin/"pgcopydb").write_env_script libexec/"pgcopydb", PATH: "$PATH:#{formula_opt_bin("libpq")}"

    system "make", "-C", "docs", "man"
    man1.install Dir["docs/_build/man/*"]
  end

  def caveats
    <<~EOS
      Pgcopydb searches for PostgreSQL command-line tools in your system's PATH environment variable.
      To use a specific PostgreSQL version's command-line tools, ensure they are accessible in your PATH.

      When no PostgreSQL tools are found in PATH, pgcopydb defaults to using the command-line tools provided by the libpq formula.
    EOS
  end

  test do
    assert_match 'Failed to export a snapshot on "postgresql://example.com"',
                 shell_output("#{bin}/pgcopydb clone --source postgresql://example.com " \
                              "--target postgresql://example.com 2>&1", 12)
  end
end
