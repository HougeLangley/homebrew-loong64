class Bmon < Formula
  desc "Interface bandwidth monitor"
  homepage "https://github.com/tgraf/bmon"
  url "https://github.com/Jafaral/bmon/archive/refs/tags/v5.0.tar.gz"
  sha256 "cd7f5fb366a8c32c0e33c79a5daae78edd273993d0edf1036638f269400cf012"
  license "BSD-2-Clause"
  head "https://github.com/tgraf/bmon.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "43b005fedb6eb23b43e9d3497c92d38ae3f95559748f424a9c788b63807c6c39"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkgconf" => :build
  depends_on "confuse"

  uses_from_macos "ncurses"

  on_linux do
    depends_on "libnl"
  end

  deny_network_access!

  def install
    system "./autogen.sh"
    system "./configure", "--mandir=#{man}", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"bmon", "-o", "ascii:quitafter=1"
  end
end
