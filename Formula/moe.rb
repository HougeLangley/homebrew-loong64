class Moe < Formula
  desc "Console text editor for ISO-8859 and ASCII"
  homepage "https://www.gnu.org/software/moe/moe.html"
  url "https://ftpmirror.gnu.org/moe/moe-1.16.tar.lz"
  mirror "https://ftp.gnu.org/gnu/moe/moe-1.16.tar.lz"
  sha256 "4c25cd78919272aebec0a7f8c126011bb5a4b5d87422807a3423216f0a17a868"
  license "GPL-2.0-or-later"


  uses_from_macos "ncurses"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ac2ba5a6a3ecde152e52f923c0889770ff02eadbc75c4418537afc3ffff401fe"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"moe", "--version"
  end
end
