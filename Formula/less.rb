class Less < Formula
  desc "Pager program similar to more"
  homepage "https://www.greenwoodsoftware.com/less/index.html"
  url "https://www.greenwoodsoftware.com/less/less-710.tar.gz"
  sha256 "d1008fb78dcae1323ddab664bcb352a61f022b1b131bd8018548e021d975ec7a"
  license "GPL-3.0-or-later"
  compatibility_version 1

  livecheck do
    url :homepage
    regex(/less[._-]v?(\d+(?:\.\d+)*).+?released.+?general use/i)
  end


  head do
    url "https://github.com/gwsw/less.git", branch: "master"
    depends_on "autoconf" => :build
    depends_on "groff" => :build
    uses_from_macos "perl" => :build
  end

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f60e22f0ee01de08c0c9102e3c258dc5b56be9984e44df39f215930769c4ebfd"
  end

  depends_on "ncurses"
  depends_on "pcre2"

  deny_network_access!

  def install
    system "make", "-f", "Makefile.aut", "distfiles" if build.head?
    system "./configure", "--prefix=#{prefix}", "--with-regex=pcre2"
    system "make", "install"
  end

  test do
    (testpath/"test.txt").write "Hello, Homebrew!\n"
    assert_equal "Hello, Homebrew!\n", shell_output("#{bin}/less test.txt")
  end
end
