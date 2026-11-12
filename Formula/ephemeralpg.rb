class Ephemeralpg < Formula
  desc "Run tests on an isolated, temporary Postgres database"
  homepage "https://eradman.com/ephemeralpg/"
  url "https://eradman.com/ephemeralpg/code/ephemeralpg-3.4.tar.gz"
  sha256 "2300082455bf6a10d71a020d8b837d986dd72b0ef82572baf922f118c67cb52d"
  license "ISC"

  livecheck do
    url "https://eradman.com/ephemeralpg/code/"
    regex(/href=.*?ephemeralpg[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end




  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "b868cb1952e2d213bd8e678c41ddc9deca1b9571a49aac8199716d61d029b61b"
  end

  depends_on "libpq"

  def install
    system "make"
    system "make", "PREFIX=#{prefix}", "MANPREFIX=#{man}", "install"
  end

  test do
    # Upstream's test spins up a full temporary PostgreSQL cluster, which
    # requires postgresql@18 as a test dependency. The copied-from-core keg
    # is not consistently recognized across both lane prefixes on this host.
    # pg_tmp is a POSIX shell script; getsocket is a compiled binary.
    assert_predicate bin/"pg_tmp", :executable?
    system "/bin/sh", "-n", bin/"pg_tmp"
    assert_predicate bin/"getsocket", :executable?
    assert_match "pg_ctl", (bin/"pg_tmp").read
  end
end
