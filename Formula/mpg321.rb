class Mpg321 < Formula
  desc "Command-line MP3 player"
  homepage "https://mpg321.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/mpg321/mpg321/0.3.2/mpg321_0.3.2.orig.tar.gz"
  sha256 "056fcc03e3f5c5021ec74bb5053d32c4a3b89b4086478dcf81adae650eac284e"
  license "GPL-2.0-or-later"
  revision 3


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "680fb49ac2ec82131c8db45ef7a911e04c1e6b9d7595b21507922b837a2b1750"
  end

  depends_on "libao"
  depends_on "libid3tag"
  depends_on "mad"

  # 1. Apple defines semun already. Skip redefining it to fix build errors.
  #    This is a homemade patch fashioned using deduction.
  # 2. Also a couple of IPV6 values are not defined on OSX that are needed.
  #    This patch was seen in the wild for an app called lscube:
  #       lscube.org/pipermail/lscube-commits/2009-March/000500.html [LOST LINK]
  # Both patches have been reported upstream here:
  # https://sourceforge.net/p/mpg321/patches/20/
  # Remove these at: Unknown.  These have not been merged as of 0.3.2.
  patch do
    file "Patches/mpg321/0.3.2.patch"
  end

  # Apply Gentoo patch for Clang 16
  patch do
    url "https://gitweb.gentoo.org/repo/gentoo.git/plain/media-sound/mpg321/files/mpg321-0.3.2-clang16.patch?id=ba6b4630d2b4cc294a3057b1f4770650bcb12c87"
    sha256 "bafc5868a8293fe465449ab27bececc6039001b1519af872ecf4178afabc1a5c"
    type :unofficial
  end

  def install
    # Fix compilation with GCC 11
    ENV.append_to_cflags "-fcommon" if OS.linux?

    system "./configure", "--disable-dependency-tracking",
                          "--disable-debug",
                          "--prefix=#{prefix}",
                          "--disable-mpg123-symlink",
                          "--enable-ipv6",
                          "--disable-alsa"
    system "make", "install"
  end

  test do
    system bin/"mpg321", "--version"
  end
end
