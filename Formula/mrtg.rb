class Mrtg < Formula
  desc "Multi router traffic grapher"
  homepage "https://oss.oetiker.ch/mrtg/"
  url "https://oss.oetiker.ch/mrtg/pub/mrtg-2.17.10.tar.gz"
  sha256 "c7f11cb5e217a500d87ee3b5d26c58a8652edbc0d3291688bb792b010fae43ac"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://oss.oetiker.ch/mrtg/pub/"
    regex(/href=.*?mrtg[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "5547de014008e468644e1b6706dfe3a027eeb34548306f5a9c9e24ee2ac795be"
  end

  depends_on "gd"
  depends_on "libpng"

  def install
    # Exclude unrecognized options
    args = std_configure_args.reject { |s| s["--disable-debug"] || s["--disable-dependency-tracking"] }

    system "./configure", *args
    system "make", "install"
  end

  test do
    system bin/"cfgmaker", "--nointerfaces", "localhost"
  end
end
