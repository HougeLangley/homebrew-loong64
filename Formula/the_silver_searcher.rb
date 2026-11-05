class TheSilverSearcher < Formula
  desc "Code-search similar to ack"
  homepage "https://geoff.greer.fm/ag/"
  url "https://github.com/ggreer/the_silver_searcher/archive/refs/tags/2.2.0.tar.gz"
  sha256 "6a0a19ca5e73b2bef9481c29a508d2413ca1a0a9a5a6b1bd9bbd695a7626cbf9"
  license "Apache-2.0"
  bottle do
    rebuild 3
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "1901950946946535c2bffbc110df18d549f21ac66ee53bb4a518b5529f5c0a11"
  end

  head "https://github.com/ggreer/the_silver_searcher.git", branch: "master"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkgconf" => :build
  depends_on "pcre2"
  depends_on "xz"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  # Apply Debian patch to port from pcre to pcre2.
  patch do
    url "https://sources.debian.org/data/main/s/silversearcher-ag/2.2.0%2Bgit20200805-1.2/debian/patches/enable_pcre2_support.patch"
    sha256 "86b4758595d96e6d049dca70b160ae4f60ea1198daa713a058628a749ab1be75"
    type :unofficial
  end

  def install
    ENV.append_to_cflags "-fcommon" if ENV.compiler.to_s.start_with?("gcc")
    # Stable tarball does not include pre-generated configure script
    system "./autogen.sh"
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make"
    system "make", "install", "bashcompdir=#{bash_completion}"
  end

  test do
    (testpath/"Hello.txt").write("Hello World!")
    system bin/"ag", "Hello World!", testpath
  end
end
