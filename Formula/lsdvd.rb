class Lsdvd < Formula
  desc "Read the content info of a DVD"
  homepage "https://sourceforge.net/projects/lsdvd/"
  url "https://git.code.sf.net/p/lsdvd/git.git",
      tag:      "0.21",
      revision: "de9cf2379335076368cc848de04a60279d944b68"
  license "GPL-2.0-only"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "02e576f5967f5fe870fb30e0dce9cbaa1d573fb53c02582bf1d927c7d78bb6a7"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkgconf" => :build
  depends_on "libdvdcss"
  depends_on "libdvdread"
  depends_on "libxml2"

  # Move `dvdlogger` function out of `main()`, as Clang (rightfully) does not allow nested functions
  # Can be removed once this has been merged: https://sourceforge.net/p/lsdvd/git/merge-requests/2/
  patch do
    file "Patches/lsdvd/logging.patch"
  end

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--mandir=#{man}", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"lsdvd", "--help"
  end
end
