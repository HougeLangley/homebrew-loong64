class W3m < Formula
  desc "Pager/text based browser"
  homepage "https://w3m.sourceforge.net/"
  url "https://git.sr.ht/~rkta/w3m/archive/v0.5.6.tar.gz"
  sha256 "8dd652cd3f31817d68c7263c34eeffb50118c80be19e1159bf8cbf763037095e"
  license "w3m"
  revision 1
  compatibility_version 1
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "3f26b260cda7e33996f14fccbdce2b452b1a79857a927a6bb79b1467ef99a517"
  end

  head "https://git.sr.ht/~rkta/w3m", branch: "master"



  depends_on "gettext" => :build
  depends_on "pkgconf" => :build
  depends_on "bdw-gc"
  depends_on "openssl@4"

  uses_from_macos "ncurses"

  on_macos do
    depends_on "gettext"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    system "./configure", "--disable-image",
                          "--with-ssl=#{formula_opt_prefix("openssl@4")}",
                          *std_configure_args
    system "make", "install"
  end

  test do
    assert_match "DuckDuckGo", shell_output("#{bin}/w3m -dump https://duckduckgo.com")
  end
end
