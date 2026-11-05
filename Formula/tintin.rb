class Tintin < Formula
  desc "MUD client"
  homepage "https://tintin.mudhalla.net/"
  url "https://github.com/scandum/tintin/releases/download/2.02.61/tintin-2.02.61.tar.gz"
  sha256 "640b4823b6f24ada6d417311bfd6263ab13be2422573c3b4ad4352223b535d88"
  license "GPL-3.0-or-later"

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "319c97c8ca5e752d61a0dc4220c29ca404fb4e9bfc33e179b11270f674584cdd"
  end

  livecheck do
    url :stable
    strategy :github_latest
  end



  depends_on "gnutls"
  depends_on "pcre2"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    # find Homebrew's libpcre
    ENV.append "LDFLAGS", "-L#{HOMEBREW_PREFIX}/lib"

    cd "src" do
      system "./configure", "--prefix=#{prefix}"
      system "make", "CFLAGS=#{ENV.cflags}",
                     "INCS=#{ENV.cppflags}",
                     "LDFLAGS=#{ENV.ldflags}",
                     "install"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tt++ -V", 1)
  end
end
