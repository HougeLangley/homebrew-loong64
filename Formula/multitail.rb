class Multitail < Formula
  desc "Tail multiple files in one terminal simultaneously"
  homepage "https://vanheusden.com/multitail/"
  url "https://github.com/folkertvanheusden/multitail/archive/refs/tags/7.1.6.tar.gz"
  sha256 "bf614c53c212238bccc86bb7ab220b6b11f3997c1900a5767df4b1a79885f421"
  license "MIT"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "1191bcf0bc8d7d1d532cab17c2e4c61c7249060158bc9a0f424d8497f789788e"
  end

  head "https://github.com/folkertvanheusden/multitail.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  depends_on "pkgconf" => :build

  deny_network_access!

  def install
    odie "Check if `inreplace` can be removed" if version > "7.1.6"
    inreplace "version" do |s|
      s.change_make_var! "VERSION", version.to_s
    end
    if OS.linux?
      inreplace "makefile.macosx" do |s|
        cflags = s.get_make_var("CFLAGS") + " -D_LARGEFILE64_SOURCE -D_GNU_SOURCE -Wno-error=implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion"
        s.change_make_var! "CFLAGS", cflags
      end
    end
    system "make", "-f", "makefile.macosx", "multitail", "DESTDIR=#{HOMEBREW_PREFIX}",
           "NCURSES_LIB=/usr/lib/libncurses.so",
           "LDFLAGS=/usr/lib/libpanel.so -lm -Wl,-rpath,/usr/lib"

    bin.install "multitail"
    man1.install Utils::Gzip.compress("multitail.1")
    etc.install "multitail.conf"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/multitail -h 2>&1", 1)
  end
end
