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
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "a90bb16aea6256ab242e048ac32270b1ef17ce498841308a8ae7650768351b43"
  end

  depends_on "postgresql@18" => :test
  depends_on "libpq"

  def install
    system "make"
    system "make", "PREFIX=#{prefix}", "MANPREFIX=#{man}", "install"
  end

  test do
    pgsql = Formula["postgresql@18"]
    ENV.prepend_path "PATH", pgsql.opt_bin
    uri = shell_output("#{bin}/pg_tmp -d #{testpath} -t")
    system pgsql.bin/"psql", uri, "-c", "\\l"
  end
end
