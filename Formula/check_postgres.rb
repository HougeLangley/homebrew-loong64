class CheckPostgres < Formula
  desc "Monitor Postgres databases"
  homepage "https://bucardo.org/wiki/Check_postgres"
  url "https://bucardo.org/downloads/check_postgres-2.26.0.tar.gz"
  sha256 "a3b135c1a205179410ee7b694e528704ebc12358781c98d3763d835872366995"
  license "BSD-2-Clause"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "81479475ca24a30538057f7d26b4b54ccce2cafc85c74e5fecb2c9e8b25b3df2"
  end

  head "https://github.com/bucardo/check_postgres.git", branch: "master"

  livecheck do
    url "https://bucardo.org/check_postgres/"
    regex(/latest version.*?v?(\d+(?:\.\d+)+)/i)
  end



  depends_on "libpq"
  uses_from_macos "perl"

  def install
    system "perl", "Makefile.PL", "INSTALL_BASE=#{prefix}", "INSTALLSITEMAN1DIR=#{man1}"
    system "make", "install"

    mkdir_p libexec/"bin"
    mv bin/"check_postgres.pl", libexec/"bin/check_postgres.pl"
    inreplace [libexec/"bin/check_postgres.pl", man1/"check_postgres.1p"], "check_postgres.pl", "check_postgres"

    (bin/"check_postgres").write_env_script libexec/"bin/check_postgres.pl", PATH: "#{formula_opt_bin("libpq")}:$PATH"

    rm_r(prefix/"lib")
  end

  test do
    # This test verifies that check_postgres fails correctly, assuming
    # that no server is running at that port.
    output = shell_output("#{bin}/check_postgres --action=connection --port=65432", 2)
    assert_match "POSTGRES_CONNECTION CRITICAL", output
  end
end
