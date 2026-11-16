class PgTop < Formula
  desc "Monitor PostgreSQL processes"
  homepage "https://pg_top.gitlab.io"
  url "https://ftp.postgresql.org/pub/projects/pgFoundry/ptop/pg_top/3.7.0/pg_top-3.7.0.tar.bz2"
  mirror "https://mirrorservice.org/sites/ftp.postgresql.org/projects/pgFoundry/ptop/pg_top/3.7.0/pg_top-3.7.0.tar.bz2"
  sha256 "c48d726e8cd778712e712373a428086d95e2b29932e545ff2a948d043de5a6a2"
  license "BSD-3-Clause"
  revision 4

  # 4.0.0 is out, but unfortunately no longer supports OS/X.  Therefore
  # we only look for the latest 3.x release until upstream adds OS/X support back.
  livecheck do
    url "https://gitlab.com/pg_top/pg_top.git"
    regex(/^v?(3(?:\.\d+)+)$/i)
  end



  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "721c9f2df7e64f5b00095c330ee3b72728b3bc968c353ee113efa577b400578b"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libpq"

  uses_from_macos "ncurses"

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--with-postgresql=#{formula_opt_prefix("libpq")}", *std_configure_args

    (buildpath/"config.h").append_lines "#define HAVE_DECL_STRLCPY 1"
    # On modern OS/X [v]snprinf() are macros that optionally add some security checks
    # In c.h this package provides their own declaration of these assuming they're
    # normal functions.  This collides with macro expansion badly but since we don't
    # need the declarations anyway just change the string to something harmless:
    inreplace "c.h", "snprintf", "unneeded_declaration_of_snprintf"
    # This file uses "vm_stats" as a symbol name which conflicts with vm_stats()
    # function in the SDK:
    inreplace "machine/m_macosx.c", "vm_stats", "vm_stats_data"
    # `configure` hardcodes `CFLAGS`; pre-C23 code redeclares `bool` and uses `()` prototypes
    system "make", "install", "CFLAGS=-std=gnu17"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pg_top -V")
  end
end
