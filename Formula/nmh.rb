class Nmh < Formula
  desc "New version of the MH mail handler"
  homepage "https://www.nongnu.org/nmh/"
  url "https://download.savannah.gnu.org/releases/nmh/nmh-1.8.tar.gz"
  mirror "https://download-mirror.savannah.gnu.org/releases/nmh/nmh-1.8.tar.gz"
  sha256 "366ce0ce3f9447302f5567009269c8bb3882d808f33eefac85ba367e875c8615"
  license "BSD-3-Clause"
  revision 2

  livecheck do
    url "https://download.savannah.gnu.org/releases/nmh/"
    regex(/href=.*?nmh[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  head do
    url "https://git.savannah.nongnu.org/git/nmh.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "5ad1c165a5fed287872a606398116ba4b6ee79fc04a0ec310da5d204549d9d8c"
  end

  depends_on "openssl@4"
  depends_on "w3m"

  uses_from_macos "cyrus-sasl"
  uses_from_macos "ncurses"

  on_linux do
    depends_on "gdbm"
    depends_on "readline"
  end

  conflicts_with "ali", because: "both install `ali` binaries"
  conflicts_with "cargo-dist", because: "both install `dist` binaries"
  conflicts_with "pick", because: "both install `pick` binaries"
  conflicts_with "repl", because: "both install `repl` binaries"

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}", "--libdir=#{libexec}",
                          "--with-cyrus-sasl",
                          "--with-tls"
    system "make", "install"

    # Remove shim references
    inreplace prefix/"etc/nmh/mhn.defaults", Superenv.shims_path/"curl", "curl"
  end

  test do
    (testpath/".mh_profile").write "Path: Mail"
    (testpath/"Mail/inbox/1").write <<~EOS
      From: Mister Test <test@example.com>
      To: Mister Nobody <nobody@example.com>
      Date: Tue, 5 May 2015 12:00:00 -0000
      Subject: Hello!

      How are you?
    EOS
    ENV["TZ"] = "GMT"
    output = shell_output("#{bin}/scan -width 80")
    assert_equal("   1  05/05 Mister Test        Hello!<<How are you? >>\n", output)
  end
end
